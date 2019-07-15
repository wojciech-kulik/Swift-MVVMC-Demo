import Swinject
import SwinjectAutoregistration

extension Container {
    
    func registerServices() {
        self.autoregister(DataManager.self, initializer: UserDataManager.init).inObjectScope(.container)
        self.autoregister(BackendRestClient.self, initializer: BackendRestClient.init).inObjectScope(.container)
        self.autoregister(AlertDispatcher.self, initializer: AlertDispatcher.init).inObjectScope(.container)
        self.autoregister(SessionService.self, initializer: SessionService.init).inObjectScope(.container)
        self.autoregister(TranslationsService.self, initializer: TranslationsService.init).inObjectScope(.container)
        self.autoregister(HttpClient.self, initializer: HttpClientMock.init).inObjectScope(.container)
    }
}
