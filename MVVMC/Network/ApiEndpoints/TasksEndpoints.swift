import Foundation

enum TasksEndpoints {
	
    class FetchTasks: BaseApiRequest<[String]> {
        init() {
            super.init(resource: "tasks")
        }
    }
}
