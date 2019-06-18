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
        let states = ["В процессе", "Завершена", "Не начата", "Отложена"]
        let timeInterval: TimeInterval = 30*24*60*60
        let startDate = Date()
        let endDate = Date(timeInterval: timeInterval, since: startDate)
        var taskNumber = 0
        for i in 0..<4{
            for j in 0..<2{
                let taskImage = states.randomElement()!
                let executor = employees[i].getFullName()
                let task = Task(name: taskNames[taskNumber],
                                projectName: projects[i].getName(),
                                numberOfNeededHours: 30,
                                startDate: startDate,
                                endDate: endDate,
                                status: taskImage,
                                executor: executor)
                taskNumber += 1
                employees[i].add(task: task)
                projects[i].add(task: task)
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
                                    position: postiton,
                                    tasks: [Task]())
            employees.append(employee)
        }
    }
    
    func getNewProject(project: Project) {
        for i in 0..<projects.count {
            if project == projects[i] {
                let projTasks = project.getTasks()
                setProjectNameFor(projTasks: projTasks, name: project.getName())
                projects[i] = project
                return
            }
        }
        projects.append(project)
    }
    
    private func setProjectNameFor(projTasks: [Task], name: String) {
        for projTask in projTasks {
            for task in tasks {
                if task == projTask {
                    task.set(projectName: name)
                }
            }
        }
    }
    
    func getNewTask(task: Task) {
        for i in 0..<tasks.count {
            if task == tasks[i] {
                tasks[i] = task
                addToProject(task: task)
                addToEmployee(task: task)
                return
            }
        }
        addToProject(task: task)
        addToEmployee(task: task)
        tasks.append(task)
    }
    
    func getNewEmployee(employee: Employee) {
        for i in  0..<employees.count {
            if employee == employees[i] {
                employees[i] = employee
                return
            }
        }
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
    
    func returnTasksCountWithProjectName(name: String) -> Int {
        for project in projects {
            if project.getName() == name {
                return project.tasksCount
            }
        }
        return 0
    }
    
    func returnTaskForProjectName(name: String, at index: Int) -> Task? {
        for project in projects {
            if project.getName() == name {
                return project.taskAtIndex(index: index)
            }
        }
        return nil
    }
    
    func removeTaskAt(index: Int, project: Project?) {
        guard var sentProject = project else {
            let taskToDelete = tasks[index]
            removeFromProject(task: taskToDelete)
            tasks.remove(at: index)
            return
        }
        let task = sentProject.taskAtIndex(index: index)
        for project in projects {
            if project == sentProject {
                project.remove(task: task)
            }
        }
        removeFromTasks(task: task)
        removeFromEmployee(task: task)
    }
    
    private func removeFromTasks(task: Task) {
        tasks.removeAll { (listTask) -> Bool in
            if listTask == task {
                return true
            }
            else {
                return false
            }
        }
    }
    
    private func removeFromProject(task: Task) {
        for project in projects {
            if project.contains(task: task) {
                project.remove(task: task)
            }
        }
    }
    
    private func removeFromEmployee(task: Task) {
        for employee in employees {
            if employee.getFullName() == task.getExecutor() {
                employee.remove(task: task)
            }
        }
    }
    
    private func addToProject(task: Task) {
        for project in projects {
            if project.contains(task: task) {
                project.remove(task: task)
            }
        }
        for project in projects {
            if task.getProjectName() == project.getName() {
                project.add(task: task)
                return
            }
        }
    }
    
    private func addToEmployee(task: Task) {
        
        for employee in employees {
            if employee.contains(task: task) {
                employee.remove(task: task)
                break
            }
        }
        
        for employee in employees {
            if employee.getFullName() == task.getExecutor() {
                employee.add(task: task)
            }
        }
    }
    
    
    func removeProjectAtIndex(index: Int) {
        let projTasks = projects[index].getTasks()
        for task in projTasks {
            tasks.removeAll { (listTask) -> Bool in
                            if listTask == task {
                                return true
                            }
                            else {
                                return false
                            }
            }
        }
        projects.remove(at: index)
    }
    
    func removeEmployeeAt(index: Int) {
        let tasks = employees[index].getTasks()
        addTasksToRandomEmployee(employeeTasks: tasks, from: employees[index])
        employees.remove(at: index)
    }
    
    private func addTasksToRandomEmployee(employeeTasks: [Task], from deletedEmployee: Employee) {
        if employees.count > 1 {
            for employeeTask in employeeTasks {
                for task in tasks {
                    if task == employeeTask {
                        let randomIndex = getRandomIndex(except: deletedEmployee)
                        employees[randomIndex].add(task: task)
                        task.set(executor: employees[randomIndex].getFullName())
                    }
                }
            }
            
        }
        else {
            for employeeTask in employeeTasks {
                for task in tasks {
                    if task == employeeTask {
                        task.set(executor: "нет")
                    }
                }
            }
        }
    }
    
    private func getRandomIndex(except employee: Employee ) -> Int {
        var index = Int(arc4random()%UInt32(employees.count))
        while employees[index] == employee{
            index = Int(arc4random()%UInt32(employees.count))
        }
        return index
    }
}

