import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
        autoregister(DataManager.self, initializer: UserDataManager.init).inObjectScope(.container)
        autoregister(BackendRestClient.self, initializer: BackendRestClient.init).inObjectScope(.container)
        autoregister(AlertDispatcher.self, initializer: AlertDispatcher.init).inObjectScope(.container)
        autoregister(SessionService.self, initializer: SessionService.init).inObjectScope(.container)
        autoregister(TranslationsService.self, initializer: TranslationsService.init).inObjectScope(.container)
        autoregister(HttpClient.self, initializer: HttpClientMock.init).inObjectScope(.container)
    }
}
