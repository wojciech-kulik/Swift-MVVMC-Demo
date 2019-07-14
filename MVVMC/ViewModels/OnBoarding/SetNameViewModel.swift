import Foundation
import RxSwift

class SetNameViewModel {
    
    private let disposeBag = DisposeBag()
    
    let firstName = BehaviorSubject(value: "")
    let lastName = BehaviorSubject(value: "")
    let didTapNext = PublishSubject<Void>()
    let isNextActive = BehaviorSubject<Bool>(value: false)
    
    init() {
        self.setUpBindings()
    }
    
    private func setUpBindings() {
        Observable
            .combineLatest(self.firstName, self.lastName)
            .map { $0.hasNonEmptyValue() && $1.hasNonEmptyValue() }
            .bind(to: self.isNextActive)
            .disposed(by: self.disposeBag)
    }
}
