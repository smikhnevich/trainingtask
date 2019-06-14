import UIKit

class TasksViewController: UIViewController, TasksManagerDelegate {

    private let tasksManager = TasksManager()
    
    @IBOutlet weak var tasksTableView: TasksTableView!
    
    private var editSegueIdentifier = "goToEditTask"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == editSegueIdentifier {
            if let task = sender as? Task {
                if let project = tasksManager.currentTasksProject() {
                    performWith(segue: segue, task: task, project: project)
                }
                else {
                    performWithTask(segue: segue, task: task)
                }
            }
            else {
                return
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
    
    private func createWithProject(segue: UIStoryboardSegue, project: Project) {
        let vc = segue.destination as! EditingTasksViewController
        vc.setTasksProjectName(name: project.getName())
    }

    func shouldPerformSegue(name: String, for task: Task) {
        performSegue(withIdentifier: name, sender: task)
    }
    
    func shouldRemoveTableViewRow(indexPath: IndexPath) {
        tasksTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
