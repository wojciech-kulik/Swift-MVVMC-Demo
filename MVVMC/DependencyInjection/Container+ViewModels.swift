import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        autoregister(SignInViewModel.self, initializer: SignInViewModel.init)
        autoregister(DrawerMenuViewModel.self, initializer: DrawerMenuViewModel.init)
        autoregister(DashboardViewModel.self, initializer: DashboardViewModel.init)
        autoregister(SettingsViewModel.self, initializer: SettingsViewModel.init)
        
        autoregister(SetNameViewModel.self, initializer: SetNameViewModel.init)
        autoregister(SetOptionsViewModel.self, initializer: SetOptionsViewModel.init)
    }
}
