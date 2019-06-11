import Foundation
import UIKit

class MenuManager: NSObject, ManagerProtocol{

    private var menuOptionsNames = ["Проекты", "Задачи", "Сотрудники", "Настройки"]
    private let cellIdentifier =  "menuOption"
    
    private var seguesIdentifiers = ["goToProjects", "goToTasks", "goToEmployees", "goToSettings"]
    
    /*
    private let projectsSegueName = "goToProjects"
    private let tasksSegueName = "goToTask"
    private let employeesSegueName = "goToEmployees"
     */
 
    var delegate: MenuHandlerDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptionsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MainMenuOptionCell
        cell.setOptionName(name: menuOptionsNames[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.shouldPerformSegue(self, segueIdentifier: seguesIdentifiers[indexPath.item])
    }
    
    
    
}
