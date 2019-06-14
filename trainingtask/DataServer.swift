import UIKit

class DataServer: NSObject {
    
    private var projects = [Project]()
    private var tasks = [Task]()
    private var employees = [Employee]()
    
    private var separator = " "
    
    override init() {
        super.init()
        initTestData()
    }
    
    private func initTestData(){
        initProjects()
        initEmployees()
        initTasks()
    }
    
    private func initProjects(){
        var projectsNames = ["Telegram", "VK", "HearthStone", "Maps"]
        var discription = ["Мессенджер", "Социальная сеть", "Карточная игра", "Карты для навигации"]
        for i in 0..<4 {
            let project = Project(name: projectsNames[i],
                                  discription: discription[i],
                                  tasks: [Task]())
            projects.append(project)
        }
    }
    
    private func initTasks(){
        let taskNames = ["Улучшение шифрования",
                         "Улучшение пользовательского интерфейса",
                         "Добавление сторис",
                         "Добавление бОльшего кол-ва рекламы",
                         "Добавление новых карт",
                         "Добавление баланса",
                         "Добавление отслеживания транспорта",
                         "Обновление маршрутов"]
        let taskDateFormatter = TaskDateFormatter()
        let startDate = Date()
        let endDate = taskDateFormatter.addDefaultDaysNumberToDate(date: startDate)
        var taskNumber = 0
        for i in 0..<4{
            for j in 0..<2{
                let taskImage = j%2 == 0 ? ("\(TaskState.active)") : "\(TaskState.closed)"
                let executor = employees[i].lastName +
                    separator +
                    employees[i].firstName +
                    separator +
                    employees[i].patronymic
                let task = Task(statusImage: taskImage,
                                name: taskNames[taskNumber],
                                projectName: projects[i].getName(),
                                numberOfNeededHours: 30,
                                startDate: startDate,
                                endDate: endDate,
                                executor: executor)
                taskNumber += 1
                projects[i].addTask(task: task)
                tasks.append(task)
            }
        }
        
    }
    
    private func initEmployees() {
        let lastNames = ["Иванов", "Сидоров", "Петров", "Кошелев"]
        let firstNames = ["Иван", "Виктор", "Александр", "Владимир"]
        let patronymics = ["Иванович", "Олегович", "Александрович", "Алексеевич"]
        let postiton = "разработчик"
        for i in 0..<4 {
            let employee = Employee(firstName: firstNames[i],
                                    lastName: lastNames[i],
                                    patronymic: patronymics[i],
                                    position: postiton)
            employees.append(employee)
        }
    }
    
    func getNewProject(project: Project) {
        projects.append(project)
    }
    
    func getNewTask(task: Task) {
        tasks.append(task)
    }
    
    func getNewEmployee(employee: Employee) {
        employees.append(employee)
    }
    
    func returnNumberOfProjects() -> Int {
        return projects.count
    }
    
    func returnNumberOfTasks() -> Int {
        return tasks.count
    }
    
    func returnNumberOfEmployees() -> Int {
        return employees.count
    }
    
    func returnProject(at index: Int) -> Project {
        return projects[index]
    }
    
    func returnTask(at index: Int) -> Task {
        return tasks[index]
    }
    
    func returnEmployee(at index: Int) -> Employee {
        return employees[index]
    }
    
    func returnTasksCountWithProjectName(name: String) -> Int? {
        for i in 0..<projects.count {
            if projects[i].getName() == name {
                return projects[i].tasksCount
            }
        }
        return nil
    }
    
    func returnTaskForProjectName(name: String, at index: Int) -> Task? {
        for i in 0..<projects.count {
            if projects[i].getName() == name {
                return projects[i].taskAtIndex(index: index)
            }
        }
        return nil
    }
    
    func removeTaskAt(index: Int) {
        tasks.remove(at: index)
    }
    
    func removeProjectAtIndex(index: Int) {
        projects.remove(at: index)
    }
    
    func removeEmployeeAt(index: Int) {
        employees.remove(at: index)
    }
}

