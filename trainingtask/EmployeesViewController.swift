import UIKit

class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var employeesTableView: EmployeesTableView!
    
    private let employeesManager = EmployeesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeesTableView.delegate = employeesManager
        employeesTableView.dataSource = employeesManager
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employeesTableView.reloadData()
    }
    
}
