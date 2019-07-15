import Foundation
import UIKit
import RxSwift
import RxCocoa

class DrawerMenuViewController: UIViewController, Storyboarded {
    static var storyboard = AppStoryboard.drawer
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private var selectedRow: Int = 0
    private let disposeBag = DisposeBag()
    var viewModel: DrawerMenuViewModel? {
        didSet {
            self.setUpBindings()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = viewModel?.fullName
        self.emailLabel.text = viewModel?.emailAddress
    }
    
    private func setUpBindings() {
        guard let viewModel = self.viewModel, self.tableView != nil else { return }
        
        self.selectedRow = 0
        
        viewModel.menuItems
            .bind(to: self.tableView.rx.items(cellIdentifier: "defaultCell")) { [weak self] row, model, cell in
                cell.selectionStyle = .none
                cell.textLabel?.text = model.localizedUpper
                cell.textLabel?.textColor = self?.selectedRow == row ? .white : .darkGray
                cell.backgroundColor = self?.selectedRow == row
                    ? Constants.mainColor
                    : UIColor.clear
            }
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }
                self.selectedRow = indexPath.row
                self.tableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.dismiss(animated: true) {
                        let selectedScreen = DrawerMenuScreen(rawValue: indexPath.row) ?? .dashboard
                        self.viewModel?.didSelectScreen.onNext(selectedScreen)
                    }
                }
            })
            .disposed(by: self.disposeBag)
        
        self.tableView.reloadData()
    }
}
