import UIKit

class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var employeesTableView: EmployeesTableView!
    
    private let employeesManager = EmployeesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeesTableView.delegate = employeesManager
        employeesTableView.dataSource = employeesManager
    }
    @IBAction func addEmployee(_ sender: Any) {
        
    }
    
}
