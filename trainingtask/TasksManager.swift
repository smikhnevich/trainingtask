import UIKit

class TasksManager: NSObject, ManagerProtocol {
    
    private var tasks = [Task]()
    
    private let cellIdentifier = "task"
    
    override init() {
        super.init()
        for i in 0..<5 {
            let task = Task(statusImage: "\(i)", name: "\(i)", projectName: "\(i)")
            tasks.append(task)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TaskCell
        cell.setTaskInfo(info: tasks[indexPath.item])
        return cell
    }
    
    
    
}