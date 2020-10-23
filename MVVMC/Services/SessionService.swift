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
        return signOutSubject.asObservable()
    }
    var didSignIn: Observable<Void> {
        return signInSubject.asObservable()
    }
    
    // MARK: - Public Methods
    
    init(dataManager: DataManager, restClient: BackendRestClient, translationsService: TranslationsService) {
        self.dataManager = dataManager
        self.restClient = restClient
        self.translationsService = translationsService
        
        loadSession()
    }
    
    func signIn(credentials: Credentials) -> Completable {
        let signIn = restClient.request(SessionEndpoints.SignIn(credentials: credentials))
        let fetchMe = restClient.request(SessionEndpoints.FetchMe())
        
        return translationsService.fetchTranslations()
            .andThen(signIn)
            .do(onSuccess: { [weak self] in try self?.setToken(response: $0) })
            .flatMap { _ in fetchMe }
            .do(onSuccess: { [weak self] in try self?.setSession(credentials: credentials, response: $0) })
            .asCompletable()
    }
    
    func signOut() -> Completable {
        let signOut = restClient.request(SessionEndpoints.SignOut())
        
        return signOut
            .do(onSuccess: { [weak self] _ in self?.removeSession() })
            .asCompletable()
    }
    
    func refreshProfile() -> Single<MeResponse> {
        let fetchMe = restClient.request(SessionEndpoints.FetchMe())
        
        return fetchMe
            .do(onSuccess: { [weak self] in self?.updateProfile(data: $0) })
    }
    
    // MARK: - Session Management
    
    private func setToken(response: SignInResponse) throws {
        guard let accessToken = response.accessToken, let tokenType = response.tokenType else {
            throw SessionError.invalidToken
        }
        
        token = Token(token: accessToken, tokenType: tokenType)
    }
    
    private func setSession(credentials: Credentials, response: MeResponse) throws {
        guard let token = token else {
            throw SessionError.invalidToken
        }
        
        sessionState = Session(
            token: token,
            email: credentials.username.lowercased(),
            profile: response)
        dataManager.set(key: SettingKey.session, value: sessionState)
        
        signInSubject.onNext(Void())
    }
    
    private func loadSession() {
        sessionState = dataManager.get(key: SettingKey.session, type: Session.self)
    }
    
    private func removeSession() {
        dataManager.clear()
        token = nil
        sessionState = nil
        signOutSubject.onNext(Void())
    }
    
    private func updateProfile(data: MeResponse) {
        sessionState?.updateDetails(data)
        dataManager.set(key: SettingKey.session, value: sessionState)
    }
}
