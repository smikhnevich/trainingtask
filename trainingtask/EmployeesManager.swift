import UIKit

class EmployeesManager: NSObject, ManagerProtocol {
    
    private var employees = [Employee]()
    
    private let cellIndentifier = "employee"
    
    override init() {
        super.init()
        for i in 0..<5 {
            let employee = Employee(firstName: "\(i)", lastName: "\(i)", patronymic: "\(i)", position: "\(i)")
            employees.append(employee)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) as! EmployeeCell
        cell.setEmployeeInfo(info: employees[indexPath.item])
        return cell
    }
}
