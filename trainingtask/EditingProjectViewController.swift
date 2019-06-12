import UIKit

class EditingProjectViewController: UIViewController {
    
    
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectDiscription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func createNewProject() -> Project {
        let name = projectName.text!
        let discription = projectDiscription.text!
        let newProject = Project(name: name, discription: discription)
        return newProject
    }
    
    private func uploadNewProjectToServer() {
        let newProject = createNewProject()
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
