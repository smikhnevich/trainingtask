import Foundation

class Project{
    
    private var name: String
    private var discription: String
    private var tasks: [Task]
    private var index: Int
    private static var indexCounter = 0
    
    init(name: String, discription: String, tasks: [Task]) {
        self.name = name
        self.discription = discription
        self.tasks = tasks
        index = Project.indexCounter
        Project.indexCounter += 1
    }
    
    func getName() -> String {
        return name
    }
    
    func getDiscription() -> String {
        return discription
    }
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func taskAtIndex(index: Int) -> Task {
        return tasks[index]
    }

    func getTasks() -> [Task] {
        return tasks
    }
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func contains(task: Task) -> Bool {
        if tasks.contains(where: { (projTask) -> Bool in
                                if projTask == task {
                                    return true
                                }
                                else{
                                    return false
                                }
                        })
        {
            return true
        }
        else {
            return false
        }
    }
    
    func remove(task: Task) {
        tasks.removeAll { (projTask) -> Bool in
            if projTask == task {
                return true
            }
            else{
                return false
            }
        }
    }
    
    func set(name: String) {
        self.name = name
    }

    func set(discription: String) {
        self.discription = discription
    }
    
    static func == (left: Project, right: Project) -> Bool {
        if left.index == right.index {
            return true
        }
        else {
            return false
        }
    }

}
