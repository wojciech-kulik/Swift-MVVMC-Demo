import RxSwift

class DrawerMenuViewModel {
    private let disposeBag = DisposeBag()
    private let sessionService: SessionService
    private let dataManager: DataManager
    
    let didSelectScreen = BehaviorSubject(value: DrawerMenuScreen.dashboard)
    
    var fullName: String {
        guard let onBoarding = dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) else { return "n/a" }
        return "\(onBoarding.firstName) \(onBoarding.lastName)"
    }
    
    var emailAddress: String {
        return sessionService.sessionState?.email ?? "n/a"
    }
    
    let menuItems = Observable.just([
        "Dashboard",
        "Settings",
        "SignOut"
    ])
    
    init(sessionService: SessionService, dataManager: DataManager) {
        self.sessionService = sessionService
        self.dataManager = dataManager
    }
}
