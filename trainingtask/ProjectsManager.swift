import Foundation
import UIKit

class ProjectsManager: NSObject, ManagerProtocol {

    private let cellIdentifier = "project"
    private var cellActions = [UITableViewRowAction]()
    
    private var editActionTitle = "Ред."
    private var deleteActionTitle = "Удалить"

    private var goToProjectEditingSegueName = "goToEdit"
    private var goToProjectTasksSegueName = "goToProjectTasks"
    
    private var editActionStyle = UITableViewRowAction.Style.default
    private var deleteActionStyle = UITableViewRowAction.Style.destructive
    
    weak var delegate: ProjectsManagerDelegate?
    
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
    
    override init(){
        super.init()
        createActions()
    }
    
    private func projectForRow(row: Int) -> Project {
        let project = self.databaseConnection().loadProjectFromServer(at: row)
        return project
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let projectsCount = databaseConnection().loadProjectsCountFromServer()
        let maxRowsNumber = settingsConnection().returnMaxLinesNumber()
        if projectsCount <= maxRowsNumber {
            return projectsCount
        }
        else {
            return maxRowsNumber
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProjectCell
        let project = databaseConnection().loadProjectFromServer(at: indexPath.item)
        cell.setProjectInfo(info: project)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return cellActions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let project = projectForRow(row: indexPath.row)
        delegate?.shouldPerformSegue(name: goToProjectTasksSegueName, for: project)
    }
    
    private func createActions() {
        let editAction = UITableViewRowAction(style: editActionStyle, title: editActionTitle) { (action, indexPath) in
            let project = self.projectForRow(row: indexPath.row)
            self.delegate?.shouldPerformSegue(name: self.goToProjectEditingSegueName, for: project)
        }
        editAction.backgroundColor = UIColor.lightGray
        let deleteAction = UITableViewRowAction(style: deleteActionStyle, title: deleteActionTitle) { (action, indexPath) in
            self.databaseConnection().removeProjectAt(index: indexPath.item)
            self.delegate?.shouldRemoveTableViewRow(indexPath: indexPath)
        }
        cellActions.append(contentsOf: [deleteAction, editAction])
    }
    
}
