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
        setUpView()
    }
    
    private func setUpView() {
        guard let viewModel = viewModel else { return }
        
        title = viewModel.title
        tableView.tableFooterView = UIView()
        
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.tasks
            .bind(to: tableView.rx.items(cellIdentifier: "defaultCell")) { row, model, cell in
                cell.textLabel?.text = model
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
}
