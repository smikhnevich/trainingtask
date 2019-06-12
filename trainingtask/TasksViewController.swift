import UIKit

class TasksViewController: UIViewController {
    
    private let tasksHandler = TasksManager()
    
    @IBOutlet weak var tasksTableView: TasksTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.delegate = tasksHandler
        tasksTableView.dataSource = tasksHandler
    }
    
}
