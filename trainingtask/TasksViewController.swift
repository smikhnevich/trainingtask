import UIKit

class TasksViewController: UIViewController, TasksManagerDelegate {

    private let tasksManager = TasksManager()
    
    @IBOutlet weak var tasksTableView: TasksTableView!
    
    private let refreshControl = UIRefreshControl()
    private var editSegueIdentifier = "goToEditTask"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRefreshControl()
        tasksTableView.refreshControl = refreshControl
        tasksTableView.delegate = tasksManager
        tasksTableView.dataSource = tasksManager
        tasksManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksTableView.reloadData()
    }
    
    func setTasksProject(project: Project) {
        tasksManager.setTasksProject(project: project)
    }
    
    func shouldPerformSegue(name: String, for task: Task) {
        performSegue(withIdentifier: name, sender: task)
    }
    
    //перепроектировать
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editSegueIdentifier {
            if let project = tasksManager.currentTasksProject() {
                if let task = sender as? Task {
                    performWith(segue: segue, task: task, project: project)
                }
                else {
                    performWithProject(segue: segue, project: project)
                }
            } else if let task = sender as? Task {
                performWithTask(segue: segue, task: task)
            }
        }
    }
    
    private func performWith(segue: UIStoryboardSegue, task: Task, project: Project) {
        let vc = segue.destination as! EditingTasksViewController
        vc.setTaskForEditing(task: task)
        vc.setTasksProjectName(name: project.getName())
    }
    
    private func performWithTask(segue: UIStoryboardSegue, task: Task) {
        let vc = segue.destination as! EditingTasksViewController
        vc.setTaskForEditing(task: task)
    }
    
    private func performWithProject(segue: UIStoryboardSegue, project: Project) {
        let vc = segue.destination as! EditingTasksViewController
        vc.setTasksProjectName(name: project.getName())
    }
    
    private func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        tasksTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func shouldRemoveTableViewRow(indexPath: IndexPath) {
        tasksTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
