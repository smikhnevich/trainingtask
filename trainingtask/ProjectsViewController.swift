import Foundation
import UIKit

class ProjectsViewController: UIViewController {
    
    @IBOutlet weak var projectsTableView: ProjectsTableView!
    
    private let projectsManager = ProjectsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTableView.delegate = projectsManager
        projectsTableView.dataSource = projectsManager
    }
    
}
