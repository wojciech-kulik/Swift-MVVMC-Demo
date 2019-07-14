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
        self.setUpBindings()
    }
    
    private func setUpBindings() {
        guard let viewModel = self.viewModel else { return }
        
        self.title = viewModel.title
        
        viewModel.notifications
            .bind(to: self.sendNotificationsSwitch.rx.isOn)
            .disposed(by: self.disposeBag)
        
        viewModel.gpsTracking
            .bind(to: self.gpsTrackingSwitch.rx.isOn)
            .disposed(by: self.disposeBag)
        
        self.sendNotificationsSwitch.rx.isOn
            .skip(1)
            .bind(to: viewModel.notifications)
            .disposed(by: self.disposeBag)
        
        self.gpsTrackingSwitch.rx.isOn
            .skip(1)
            .bind(to: viewModel.gpsTracking)
            .disposed(by: self.disposeBag)
    }
}
