import UIKit

class EditingProjectViewController: UIViewController {
    
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectDiscription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if project != nil {
            initFromProject()
        }
    }
    
    private var project: Project?
    
    func setProject(project: Project) {
        self.project = project
    }
    
    private func initFromProject() {
        projectName.text = project?.getName()
        projectDiscription.text = project?.getDiscription()
    }
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func createProject() -> Project {
        let name = projectName.text!
        let discription = projectDiscription.text!
        if project != nil {
            let newProject = Project(name: name,
                                     discription: discription,
                                     tasks: project!.getTasks())
            return newProject
        }
        else {
            let newProject = Project(name: name,
                                     discription: discription,
                                     tasks: [Task]())
            return newProject
        }
    }
    
    private func uploadNewProjectToServer() {
        let newProject = createProject()
        databaseConnection().loadNewProjectToServer(project: newProject)
    }
    
    @IBAction func readyPressed(_ sender: Any) {
        uploadNewProjectToServer()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
