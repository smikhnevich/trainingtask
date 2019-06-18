import UIKit

class TasksManager: NSObject, ManagerProtocol {
    
    private let cellIdentifier = "task"
    private var tasksProject: Project?
    private var editSegueIdentifier = "goToEditTask"
    private var cellActions = [UITableViewRowAction]()
    private let deleteActionTitle = "Удалить"
    private let deleteButtonStyle = UITableViewRowAction.Style.destructive
    
    weak var delegate: TasksManagerDelegate?
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func settingsConnection() -> SettingsManager {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.settingsConnection
    }
    
    override init() {
        super.init()
        createCellActions()
    }
    
    func currentTasksProject() -> Project? {
        return tasksProject
    }
    
    func setTasksProject(project: Project) {
        tasksProject = project
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tasksCount = rowsNumber()
        return tasksCount
    }
    
    private func rowsNumber() -> Int {
        var tasksCount = Int()
        if let project = tasksProject {
            tasksCount = databaseConnection().loadTasksCountForProject(name: project.getName())!
        }
        else {
            tasksCount = databaseConnection().loadTasksCountFromServer()
        }
        let maxRowsNumber = settingsConnection().returnMaxLinesNumber()
        if tasksCount <= maxRowsNumber {
            return tasksCount
        }
        else {
            return maxRowsNumber
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! TaskCell
        var task: Task?
        if let project = tasksProject {
            task = databaseConnection().loadTaskForProject(name: project.getName(), at: indexPath.item)
            cell.projectNameIsHidden(true)
        }
        else {
            task = databaseConnection().loadTaskFromServer(at: indexPath.item)
        }
        cell.setTaskInfo(info: task!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        var task: Task?
        if tasksProject != nil {
            task = tasksProject!.taskAtIndex(index: indexPath.item)
        }
        else {
            task = databaseConnection().loadTaskFromServer(at: indexPath.item)
        }
        delegate?.shouldPerformSegue(name: editSegueIdentifier, for: task!)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return cellActions
    }
    
    private func createCellActions() {
        let deleteAction = UITableViewRowAction(style: deleteButtonStyle,
                                                title: deleteActionTitle)
        { (action, indexPath) in
            self.databaseConnection().removeTaskAt(index: indexPath.item, project: self.tasksProject)
            self.delegate?.shouldRemoveTableViewRow(indexPath: indexPath)
        }
        cellActions.append(deleteAction)
    }
}
