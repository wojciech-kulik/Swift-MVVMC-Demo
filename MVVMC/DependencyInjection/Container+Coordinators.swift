import Swinject

extension Container {
    func registerCoordinators() {
        autoregister(AppCoordinator.self, initializer: AppCoordinator.init)
        autoregister(SignInCoordinator.self, initializer: SignInCoordinator.init)
        autoregister(DrawerMenuCoordinator.self, initializer: DrawerMenuCoordinator.init)
        autoregister(DashboardCoordinator.self, initializer: DashboardCoordinator.init)
        autoregister(OnBoardingCoordinator.self, initializer: OnBoardingCoordinator.init)
        autoregister(SettingsCoordinator.self, initializer: SettingsCoordinator.init)
    }
}
