import UIKit

class EmployeesManager: NSObject, ManagerProtocol {
    
    private let cellIndentifier = "employee"
    private var cellActions = [UITableViewRowAction]()
    
    private let editingSegueIdentifier = "goToEmployeeEditing"
   
    override init() {
        super.init()
        createActions()
    }
    
    private var deleteActionTitle = "Удалить"
    private var deleteActionStyle = UITableViewRowAction.Style.destructive
    
    weak var delegate: EmployeesManagerDelegate?
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let employeesNumber = databaseConnection().loadEmployeesCountFromServer()
        let maxRowsNumber = settingsConnection().returnMaxLinesNumber()
        if employeesNumber <= maxRowsNumber {
            return employeesNumber
        }
        else{
            return maxRowsNumber
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) as! EmployeeCell
        let employee = databaseConnection().loadEmployeeFromServer(at: indexPath.item)
        cell.setEmployeeInfo(info: employee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employee = databaseConnection().loadEmployeeFromServer(at: indexPath.item)
        delegate?.shouldPerformSegueWith(identifier: editingSegueIdentifier, for: employee)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return cellActions
    }
    
    
    private func createActions() {
        let deleteAction = UITableViewRowAction(style: deleteActionStyle,
                                                title: deleteActionTitle)
        { (action, indexPath) in
            self.databaseConnection().removeEmployeeAt(index: indexPath.item)
            self.delegate?.shouldRemoveRowAt(indexPath: indexPath)
        }
        cellActions.append(deleteAction)
    }
}
