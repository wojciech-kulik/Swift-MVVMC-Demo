import Foundation
import UIKit
import RxSwift

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func removeChildCoordinators()
}

class BaseCoordinator<Result>: Coordinator {
    
    let disposeBag = DisposeBag()
    var navigationController = UINavigationController()
    var childCoordinators = [Coordinator]()
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Maybe<T> {
        self.store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self, weak coordinator] _ in
                guard let coordinator = coordinator, let `self` = self else { return }
                self.free(coordinator: coordinator)
            })
    }
    
    func start() -> Maybe<Result> {
        fatalError("Start method should be implemented.")
    }
    
    func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
    }
    
    private func store(coordinator: Coordinator) {
        self.childCoordinators += [coordinator]
    }
    
    private func free(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
