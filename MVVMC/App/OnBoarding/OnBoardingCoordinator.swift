import Foundation
import RxSwift
import UIKit

class OnBoardingCoordinator: BaseCoordinator<OnBoardingData> {

    var onBoardingViewController: BaseNavigationController!
    
    private let dataManager: DataManager
    private let setNameViewModel: SetNameViewModel
    private let setOptionsViewModel: SetOptionsViewModel
    private let onBoardingFinished = PublishSubject<OnBoardingData>()
    
    init(setNameViewModel: SetNameViewModel, setOptionsViewModel: SetOptionsViewModel,
         dataManager: DataManager) {
        self.setNameViewModel = setNameViewModel
        self.setOptionsViewModel = setOptionsViewModel
        self.dataManager = dataManager
    }
    
    override func start() -> Maybe<OnBoardingData> {
        self.setUpBindings()
        
        let viewController = SetNameViewController.instantiate()
        viewController.viewModel = self.setNameViewModel
        
        self.onBoardingViewController = BaseNavigationController(rootViewController: viewController)
        self.onBoardingViewController.navigationBar.isHidden = true
        self.navigationController.presentOnTop(self.onBoardingViewController, animated: true)
        
        return self.onBoardingFinished.take(1).asMaybe()
    }
    
    private func didSetName() {
        let viewController = SetOptionsViewController.instantiate()
        viewController.viewModel = self.setOptionsViewModel

        self.onBoardingViewController.pushViewController(viewController, animated: true)
    }
    
    private func didFinishOnBoarding(with data: OnBoardingData) {
        self.dataManager.set(key: SettingKey.onBoardingData, value: data)
        self.onBoardingViewController.dismiss(animated: true, completion: nil)
        self.onBoardingFinished.onNext(data)
    }
    
    private func setUpBindings() {
        self.setNameViewModel.didTapNext
            .subscribe(onNext: { [weak self] in self?.didSetName() })
            .disposed(by: self.disposeBag)
        
        self.setOptionsViewModel.didTapFinish
            .flatMapLatest { [weak self] () -> Observable<OnBoardingData> in
                guard let `self` = self else { return Observable.empty() }
                return Observable.combineLatest(
                    self.setNameViewModel.firstName,
                    self.setNameViewModel.lastName,
                    self.setOptionsViewModel.notifications,
                    self.setOptionsViewModel.gpsTracking)
                    .take(1)
                    .map { OnBoardingData(firstName: $0.0, lastName: $0.1, notifications: $0.2, gpsTracking: $0.3) }
            }
            .subscribe(onNext: { [weak self] data in self?.didFinishOnBoarding(with: data) })
            .disposed(by: self.disposeBag)
    }
}
