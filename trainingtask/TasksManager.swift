import UIKit

class TasksManager: NSObject, ManagerProtocol {
    
    
    private let cellIdentifier = "task"
    private var database: Database?
    
    private func connectToDataServer() {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        database = appDelegate.databaseConnection
    }
    
    override init() {
        super.init()
        connectToDataServer()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tasksCount = database!.loadTasksCountFromServer()
        return tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TaskCell
        let task = database!.loadTaskFromServer(at: indexPath.item)
        cell.setTaskInfo(info: task)
        return cell
    }
    
    
    
}
