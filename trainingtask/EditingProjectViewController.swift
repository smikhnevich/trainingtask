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
    
    private let alertTitle = "Ошибка"
    private let alertActionTitle = "Ок"
    private let errorMessages = ProjectEditingErrorMessages()
    private let progressView = ProgressView()
    
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
            project?.set(name: name)
            project?.set(discription: discription)
            return project!
        }
        else {
            let newProject = Project(name: name, discription: discription, tasks: [Task]())
            return newProject
        }
    }
    
    private func uploadNewProjectToServer() {
        let newProject = createProject()
        databaseConnection().loadNewProjectToServer(project: newProject)
    }
    
    private func isDataValid() throws {
        guard projectName.text != "" else {
            throw ProjectEditingErrors.noName
        }
        guard projectDiscription.text != "" else {
            throw ProjectEditingErrors.noDiscription
        }
    }
    
    private func handleError(error: Error) {
        let convertedError = error as! ProjectEditingErrors
        switch convertedError {
        case ProjectEditingErrors.noName:
            showAlertWith(message: errorMessages.noName)
        case ProjectEditingErrors.noDiscription:
            showAlertWith(message: errorMessages.noDisctiption)
        }
    }
    
    private func showAlertWith(message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func readyPressed(_ sender: Any) {
        do{
            try isDataValid()
            uploadNewProjectToServer()
            progressView.show(for: self) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        catch let error {
            handleError(error: error)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
