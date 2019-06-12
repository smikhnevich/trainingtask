import UIKit

class EditEmployeeViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var patronymicField: UITextField!
    @IBOutlet weak var positionField: UITextField!
    
    private var database: Database?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func createNewEmployee() -> Employee {
        let firstName = firstNameField.text!
        let lastName = lastNameField.text!
        let patronymic = patronymicField.text!
        let position = positionField.text!
        let newEmployee = Employee(firstName: firstName, lastName: lastName, patronymic: patronymic, position: position)
        return newEmployee
    }
    
    private func uploadNewEmployeeToServer() {
        let newEmployee = createNewEmployee()
        databaseConnection().loadNewEmployeeToServer(employee: newEmployee)
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        uploadNewEmployeeToServer()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
