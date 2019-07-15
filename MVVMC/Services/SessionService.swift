import Foundation
import RxSwift

class SessionService {
    
    enum SessionError: Error {
        case invalidToken
    }
    
    // MARK: - Private fields
    
    private let dataManager: DataManager
    private let restClient: BackendRestClient
    private let translationsService: TranslationsService
    
    private let signOutSubject = PublishSubject<Void>()
    private let signInSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    private var token: Token?
    
    // MARK: - Public properties
    
    private(set) var sessionState: Session?
    
    var didSignOut: Observable<Void> {
        return self.signOutSubject.asObservable()
    }
    var didSignIn: Observable<Void> {
        return self.signInSubject.asObservable()
    }
    
    // MARK: - Public Methods
    
    init(dataManager: DataManager, restClient: BackendRestClient, translationsService: TranslationsService) {
        self.dataManager = dataManager
        self.restClient = restClient
        self.translationsService = translationsService
        
        self.loadSession()
    }
    
    func signIn(credentials: Credentials) -> Completable {
        let signIn = self.restClient.request(SessionEndpoints.SignIn(credentials: credentials)) as Single<SignInResponse>
        let fetchMe = self.restClient.request(SessionEndpoints.FetchMe()) as Single<MeResponse>
        
        return self.translationsService.fetchTranslations()
            .andThen(signIn)
            .do(onSuccess: { [weak self] in try self?.setToken(response: $0) })
            .flatMap { _ in fetchMe }
            .do(onSuccess: { [weak self] in try self?.setSession(credentials: credentials, response: $0) })
            .asCompletable()
    }
    
    func signOut() -> Completable {
        let signOut = self.restClient.request(SessionEndpoints.SignOut()) as Single<VoidResponse>
        
        return signOut
            .do(onSuccess: { [weak self] _ in self?.removeSession() })
            .asCompletable()
    }
    
    func refreshProfile() -> Single<MeResponse> {
        let fetchMe = self.restClient.request(SessionEndpoints.FetchMe()) as Single<MeResponse>
        
        return fetchMe
            .do(onSuccess: { [weak self] in self?.updateProfile(data: $0) })
    }
    
    // MARK: - Session Management
    
    private func setToken(response: SignInResponse) throws {
        guard let accessToken = response.accessToken, let tokenType = response.tokenType else {
            throw SessionError.invalidToken
        }
        
        self.token = Token(token: accessToken, tokenType: tokenType)
    }
    
    private func setSession(credentials: Credentials, response: MeResponse) throws {
        guard let token = self.token else {
            throw SessionError.invalidToken
        }
        
        self.sessionState = Session(
            token: token,
            email: credentials.username.lowercased(),
            profile: response)
        self.dataManager.set(key: SettingKey.session, value: self.sessionState)
        
        self.signInSubject.onNext(Void())
    }
    
    private func loadSession() {
        self.sessionState = self.dataManager.get(key: SettingKey.session, type: Session.self)
    }
    
    private func removeSession() {
        self.dataManager.clear()
        self.token = nil
        self.sessionState = nil
        self.signOutSubject.onNext(Void())
    }
    
    private func updateProfile(data: MeResponse) {
        self.sessionState?.updateDetails(data)
        self.dataManager.set(key: SettingKey.session, value: self.sessionState)
    }
}
