import Swinject

extension Container {
    
    func registerCoordinators() {
        self.autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        self.autoregister(SignInCoordinator.self, initializer: SignInCoordinator.init)
        self.autoregister(DrawerMenuCoordinator.self, initializer: DrawerMenuCoordinator.init)
        self.autoregister(DashboardCoordinator.self, initializer: DashboardCoordinator.init)
        self.autoregister(OnBoardingCoordinator.self, initializer: OnBoardingCoordinator.init)
        self.autoregister(SettingsCoordinator.self, initializer: SettingsCoordinator.init)
    }
}
