import UIKit

class EmployeesViewController: UIViewController, EmployeesManagerDelegate {

    @IBOutlet weak var employeesTableView: EmployeesTableView!
    
    private let employeesManager = EmployeesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeesTableView.delegate = employeesManager
        employeesTableView.dataSource = employeesManager
        employeesManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        employeesTableView.reloadData()
    }
    
    func shouldRemoveRowAt(indexPath: IndexPath) {
        employeesTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func shouldPerformSegueWith(identifier: String, for employee: Employee?) {
        performSegue(withIdentifier: identifier, sender: employee)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let employee = sender as? Employee {
            let vc = segue.destination as! EditEmployeeViewController
            vc.setEmployee(employee: employee)
        }
        else {
            return
        }
    }
    
}
