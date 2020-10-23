import Foundation

enum TasksEndpoints {
    class FetchTasks: ApiRequest<[String]> {
        init() {
            super.init(resource: "tasks")
        }
    }
}
