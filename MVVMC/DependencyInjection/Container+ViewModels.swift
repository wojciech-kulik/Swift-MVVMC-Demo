import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
	
    func registerViewModels() {
        self.autoregister(SignInViewModel.self, initializer: SignInViewModel.init)
        self.autoregister(DrawerMenuViewModel.self, initializer: DrawerMenuViewModel.init)
        self.autoregister(DashboardViewModel.self, initializer: DashboardViewModel.init)
        self.autoregister(SettingsViewModel.self, initializer: SettingsViewModel.init)
        
        self.autoregister(SetNameViewModel.self, initializer: SetNameViewModel.init)
        self.autoregister(SetOptionsViewModel.self, initializer: SetOptionsViewModel.init)
    }
}
