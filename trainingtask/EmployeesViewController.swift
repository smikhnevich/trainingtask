import UIKit

class EmployeesViewController: UIViewController, EmployeesManagerDelegate {

    @IBOutlet weak var employeesTableView: EmployeesTableView!
    
    private let employeesManager = EmployeesManager()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRefreshControl()
        employeesTableView.delegate = employeesManager
        employeesTableView.dataSource = employeesManager
        employeesTableView.refreshControl = refreshControl
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
    
    private func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        employeesTableView.reloadData()
        refreshControl.endRefreshing()
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
