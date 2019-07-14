import Swinject

extension Container {
    
    func registerDependencies() {
        self.registerServices()
        self.registerCoordinators()
        self.registerViewModels()
    }
}
