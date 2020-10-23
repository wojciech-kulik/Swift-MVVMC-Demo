import Foundation
import UIKit
import RxSwift

class SettingsViewController: ViewControllerWithSideMenu, Storyboarded {
    static var storyboard = AppStoryboard.settings
    
    @IBOutlet weak var sendNotificationsSwitch: UISwitch!
    @IBOutlet weak var gpsTrackingSwitch: UISwitch!
    
    private let disposeBag = DisposeBag()
    var viewModel: SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
    private func setUpBindings() {
        guard let viewModel = viewModel else { return }
        
        title = viewModel.title
        
        viewModel.notifications
            .bind(to: sendNotificationsSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        viewModel.gpsTracking
            .bind(to: gpsTrackingSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        sendNotificationsSwitch.rx.isOn
            .skip(1)
            .bind(to: viewModel.notifications)
            .disposed(by: disposeBag)
        
        gpsTrackingSwitch.rx.isOn
            .skip(1)
            .bind(to: viewModel.gpsTracking)
            .disposed(by: disposeBag)
    }
}
