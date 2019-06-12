import UIKit

class Database: NSObject {
    
    let dataServer = DataServer()
    
    func loadNewProjectToServer(project: Project) {
        dataServer.getNewProject(project: project)
    }
    
    func loadNewTaskToServer(task: Task) {
        dataServer.getNewTask(task: task)
    }
    
    func loadNewEmployeeToServer(employee: Employee) {
        dataServer.getNewEmployee(employee: employee)
    }
    
    func loadProjectFromServer(at index: Int) -> Project {
        return dataServer.returnProject(at: index)
    }
    
    func loadTaskFromServer(at index: Int) -> Task {
        return dataServer.returnTask(at: index)
    }
    
    func loadEmployeeFromServer(at index: Int) -> Employee {
        return dataServer.returnEmployee(at: index)
    }
    
    func loadProjectsCountFromServer() -> Int {
        return dataServer.returnNumberOfProjects()
    }
    
    func loadTasksCountFromServer() -> Int {
        return dataServer.returnNumberOfTasks()
    }
    
    func loadEmployeesCountFromServer() -> Int {
        return dataServer.returnNumberOfEmployees()
    }
    
}
