import Foundation
import UIKit
import RxSwift

class DashboardViewController: ViewControllerWithSideMenu, Storyboarded {
    
    static var storyboard = AppStoryboard.dashboard
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    var viewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    private func setUpView() {
        guard let viewModel = self.viewModel else { return }
        
        self.title = viewModel.title
        self.tableView.tableFooterView = UIView()
        
        viewModel.isLoading
            .bind(to: self.activityIndicator.rx.isAnimating)
            .disposed(by: self.disposeBag)
        
        viewModel.tasks
            .bind(to: self.tableView.rx.items(cellIdentifier: "defaultCell")) { row, model, cell in
                cell.textLabel?.text = model
                cell.selectionStyle = .none
            }
            .disposed(by: self.disposeBag)
    }
}
