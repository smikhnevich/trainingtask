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
    
    func loadTasksCountForProject(name: String) -> Int? {
        return dataServer.returnTasksCountWithProjectName(name: name)
    }
    
    func loadTaskForProject(name: String, at index: Int) -> Task? {
        return dataServer.returnTaskForProjectName(name: name, at: index)
    }
    
    func removeProjectAt(index: Int) {
        dataServer.removeProjectAtIndex(index: index)
    }
    
    func removeTaskAt(index: Int) {
        dataServer.removeTaskAt(index: index)
    }
    
    func removeEmployeeAt(index: Int) {
        dataServer.removeEmployeeAt(index: index)
    }
    
}
