import Foundation
import RxSwift

class DashboardViewModel {
	
    private let sessionService: SessionService
    private let disposeBag = DisposeBag()
    private let restClient: BackendRestClient
    
    let title = "Dashboard".localized
    let isLoading = BehaviorSubject(value: true)
    var tasks = BehaviorSubject(value: [String]())
    
    init(sessionService: SessionService, restClient: BackendRestClient) {
        self.sessionService = sessionService
        self.restClient = restClient
        
        self.sessionService.refreshProfile()
            .subscribe()
            .disposed(by: self.disposeBag)
        
        self.fetchTasks()
    }
    
    private func fetchTasks() {
        self.isLoading.onNext(true)
        self.restClient.request(TasksEndpoints.FetchTasks())
            .asDriver(onErrorJustReturn: [String]())
            .do(onNext: { [weak self] _ in self?.isLoading.onNext(false) })
            .drive(self.tasks)
            .disposed(by: self.disposeBag)
    }
}
