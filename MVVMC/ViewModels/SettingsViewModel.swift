import Foundation
import RxSwift

class SettingsViewModel {
    
    private let dataManager: DataManager
    private let disposeBag = DisposeBag()
	
	let title = "Settings".localized
    let notifications = BehaviorSubject(value: false)
    let gpsTracking = BehaviorSubject(value: false)
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        
        guard let onBoarding = self.dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) else { return }
        
        self.notifications.onNext(onBoarding.notifications)
        self.gpsTracking.onNext(onBoarding.gpsTracking)
        
        Observable.combineLatest(self.notifications, self.gpsTracking)
            .subscribe(onNext: { [weak self] notifications, gpsTracking in
                guard let onBoarding = self?.dataManager.get(key: SettingKey.onBoardingData, type: OnBoardingData.self) else { return }

                let newOnBoarding = OnBoardingData(firstName: onBoarding.firstName, lastName: onBoarding.lastName,
                                                   notifications: notifications, gpsTracking: gpsTracking)
                self?.dataManager.set(key: SettingKey.onBoardingData, value: newOnBoarding)
            })
            .disposed(by: self.disposeBag)
    }
}
