import Foundation

enum TaskEditingErrors: Error {
    case noTaskName
    case noProjectName
    case noNumberOfHours
    case wrongNumberOfHours
    case noDate
    case wrongDate
    case noState
    case wrongState
    case noExecutor
}
