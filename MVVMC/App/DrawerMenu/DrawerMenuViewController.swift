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
    var viewModel: DrawerMenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        setUpBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = viewModel?.fullName
        emailLabel.text = viewModel?.emailAddress
    }
    
    private func setUpBindings() {
        guard let viewModel = viewModel, tableView != nil else { return }
        
        selectedRow = 0
        
        viewModel.menuItems
            .bind(to: tableView.rx.items(cellIdentifier: "defaultCell")) { [weak self] row, model, cell in
                cell.selectionStyle = .none
                cell.textLabel?.text = model.localizedUpper
                cell.textLabel?.textColor = self?.selectedRow == row ? .white : .darkGray
                cell.backgroundColor = self?.selectedRow == row
                    ? Constants.mainColor
                    : UIColor.clear
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.selectedRow = indexPath.row
                self.tableView.reloadData()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.dismiss(animated: true) {
                        let selectedScreen = DrawerMenuScreen(rawValue: indexPath.row) ?? .dashboard
                        self.viewModel?.didSelectScreen.onNext(selectedScreen)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        tableView.reloadData()
    }
}
