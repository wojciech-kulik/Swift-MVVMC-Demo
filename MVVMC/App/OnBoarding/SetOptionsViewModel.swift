import Foundation
import RxSwift

class SetOptionsViewModel {
    let notifications = BehaviorSubject(value: true)
    let gpsTracking = BehaviorSubject(value: true)
    let didTapFinish = PublishSubject<Void>()
}
