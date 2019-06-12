import UIKit

class EmployeesManager: NSObject, ManagerProtocol {
    
    private let cellIndentifier = "employee"
   
    override init() {
        super.init()
    }
    
    private func connectToDataServer() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let employeesNumber = connectToDataServer().loadEmployeesCountFromServer()
        print(employeesNumber)
        return employeesNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) as! EmployeeCell
        let employee = connectToDataServer().loadEmployeeFromServer(at: indexPath.item)
        cell.setEmployeeInfo(info: employee)
        return cell
    }
}
