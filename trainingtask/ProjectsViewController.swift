import Foundation
import UIKit

class ProjectsViewController: UIViewController, ProjectsManagerDelegate{
    
    @IBOutlet weak var projectsTableView: ProjectsTableView!
    
    private var goToProjectEditingSegueName = "goToEdit"
    private var goToProjectTasksSegueName = "goToProjectTasks"
    
    private let projectsManager = ProjectsManager()
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRefreshControl()
        projectsTableView.refreshControl = refreshControl
        projectsTableView.delegate = projectsManager
        projectsTableView.dataSource = projectsManager
        projectsManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        projectsTableView.reloadData()
    }
    
    func shouldPerformSegue(name: String, for project: Project) {
        performSegue(withIdentifier: name, sender: project)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == goToProjectEditingSegueName {
            if let project = sender as? Project{
                let vc = segue.destination as! EditingProjectViewController
                vc.setProject(project: project)
            }
            else {
                return
            }
        }
        if segue.identifier == goToProjectTasksSegueName {
            let project = sender as! Project
            let vc = segue.destination as! TasksViewController
            vc.setTasksProject(project: project)
        }
    }
    
    private func setUpRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        projectsTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func shouldRemoveTableViewRow(indexPath: IndexPath) {
        projectsTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
