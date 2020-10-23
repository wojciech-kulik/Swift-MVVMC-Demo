import Foundation
import UIKit
import RxSwift

class SetOptionsViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.onBoarding
    private let disposeBag = DisposeBag()
	
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var gpsTrackingSwitch: UISwitch!
    @IBOutlet weak var finishButton: LocalizedButton!
    
    var viewModel: SetOptionsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
    func setUpBindings() {
        guard let viewModel = viewModel else { return }
        
        notificationsSwitch.rx.isOn
            .bind(to: viewModel.notifications)
            .disposed(by: disposeBag)
        
        gpsTrackingSwitch.rx.isOn
            .bind(to: viewModel.gpsTracking)
            .disposed(by: disposeBag)
        
        finishButton.rx.tap
            .bind(to: viewModel.didTapFinish)
            .disposed(by: disposeBag)
    }
}
