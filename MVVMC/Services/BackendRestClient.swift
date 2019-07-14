import Foundation
import RxSwift

class BackendRestClient {
    
    private static let basicToken = "Basic 1234"
    private let sessionDidExpireSubject = PublishSubject<Void>()
    
    private let httpClient: HttpClient
    private let errorHandler: ErrorHandler
    private lazy var sessionService: SessionService? = AppDelegate.container.resolve(SessionService.self)
    
    var sessionDidExpire: Observable<Void> {
        return self.sessionDidExpireSubject.asObservable()
    }
    
    init(httpClient: HttpClient, errorHandler: ErrorHandler) {
        self.httpClient = httpClient
        self.errorHandler = errorHandler
    }
    
    // MARK: API request
    
    func request<T:Codable>(_ request: ApiRequest) -> Single<T>{

        return Single.create { single in
            self.httpClient.set(headers: self.getHeaders(for: request))
            self.httpClient.request(
                resource: request.resource,
                method: request.method,
                json: request.json,
                form: request.form) { self.process(response: $0, for: request, single: single) }
            
            return Disposables.create()
        }
    }
    
    // MARK: Private Methods
    
    private func process<T:Codable>(response: ApiResponse, for request: ApiRequest, single: Single<T>.SingleObserver) {
        response.print()
        
        guard response.success else {
            DebugUtils.log(error: response.error)
            let error = BackendError.requestFailed(statusCode: response.statusCode, rawResponse: response.data)
            dispatchError(request: request, error: error)
            single(.error(error))
            return
        }

        guard request is SessionEndpoints.SignIn || response.statusCode != RestApiStatusCodes.unauthorized.rawValue else {
            let error = BackendError.unauthorized(rawResponse: response.data)
            dispatchError(request: request, error: error)
            single(.error(error))
            self.sessionDidExpireSubject.onNext(Void())
            return
        }
        
        guard response.statusCode == request.expectedCode else {
            let error = BackendError.invalidStatusCode(statusCode: response.statusCode, rawResponse: response.data)
            dispatchError(request: request, error: error)
            single(.error(error))
            return
        }
        
        guard let parsedResponse = response.data?.toObject(T.self) else {
            let error = BackendError.requestFailed(statusCode: nil, rawResponse: response.data)
            dispatchError(request: request, error: error)
            single(.error(error))
            return
        }
        
        single(.success(parsedResponse))
    }
    
    private func dispatchError(request: ApiRequest, error: Error) {
        let message = self.getErrorMessage(error: error)
        self.errorHandler.handle(error: message)
    }
    
    private func getHeaders(for request: ApiRequest) -> [String:String] {
        return [
            "Content-Type": request.contentType,
            "Authorization": self.getAuthorizationHeader(for: request)]
    }
    
    private func getAuthorizationHeader(for request: ApiRequest) -> String {
        if request is SessionEndpoints.SignIn {
            return BackendRestClient.basicToken
        }

        if let tokenHeader = self.sessionService?.sessionState?.token.getTokenHeader() {
            return tokenHeader
        }
        
        return BackendRestClient.basicToken
    }
    
    private func getErrorMessage(error: Error) -> ErrorMessage {
        let message = ApiUtils.getApiErrorMessage(from: error) ?? "Could not process request."
        let errorMessage = ErrorMessage(title: "Error", message: message, buttons: ["OK"], actions: [:])
        return errorMessage
    }
}
