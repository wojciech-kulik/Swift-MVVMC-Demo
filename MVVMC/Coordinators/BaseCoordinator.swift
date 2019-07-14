import Foundation
import RxSwift

protocol Coordinator {
    func removeChildCoordinators()
}

class BaseCoordinator<Result>: Coordinator {
    let disposeBag = DisposeBag()
    
    private let identifier = UUID()
    private var childCoordinators = [UUID:Coordinator]()
    
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
        self.childCoordinators.forEach { tuple in
            self.childCoordinators[tuple.key]?.removeChildCoordinators()
        }
        
        self.childCoordinators.removeAll()
    }
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        self.childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        self.childCoordinators.removeValue(forKey: coordinator.identifier)
    }
}
