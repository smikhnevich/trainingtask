import UIKit

class EditEmployeeViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var patronymicField: UITextField!
    @IBOutlet weak var positionField: UITextField!
    
    private var employee: Employee?
    
    private let alertTitle = "Ошибка"
    private let alertActionTitle = "Ок"
    private let errorMessages = EditEmployeeErrorMessages()
    private let progressView = ProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if employee != nil {
            initFromEmployee()
        }
    }
    
    func setEmployee(employee: Employee) {
        self.employee = employee
    }
    
    private func initFromEmployee() {
        firstNameField.text = employee?.getFirstName()
        lastNameField.text = employee?.getLastName()
        patronymicField.text = employee?.getPatronymic()
        positionField.text = employee?.getPosition()
    }
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func isDataValid() throws {
        guard firstNameField.text != "" else{
            throw EditingEmployeeError.noFirstName
        }
        guard lastNameField.text != "" else {
            throw EditingEmployeeError.noLastName
        }
        guard patronymicField.text != "" else {
            throw EditingEmployeeError.noPatronymic
        }
        guard positionField.text != "" else {
            throw EditingEmployeeError.noPostition
        }
    }
    
    private func createEmployee() -> Employee {
        let firstName = firstNameField.text!
        let lastName = lastNameField.text!
        let patronymic = patronymicField.text!
        let position = positionField.text!
        if employee != nil {
            employee!.set(firstName: firstName)
            employee!.set(lastName: lastName)
            employee!.set(patronymic: patronymic)
            employee!.set(position: position)
            return employee!
        }
        else{
            let newEmployee = Employee(firstName: firstName, lastName: lastName, patronymic: patronymic, position: position, tasks: [Task]())
            return newEmployee
        }
    }
    
    private func handleError(error: Error) {
        let convertedError = error as! EditingEmployeeError
        switch convertedError {
        case EditingEmployeeError.noFirstName:
            showAlertWith(message: errorMessages.noFirstName)
        case EditingEmployeeError.noLastName:
            showAlertWith(message: errorMessages.noFirstName)
        case EditingEmployeeError.noPatronymic:
            showAlertWith(message: errorMessages.noPatronymic)
        case EditingEmployeeError.noPostition:
            showAlertWith(message: errorMessages.noPostition)
        }
    }
    
    private func showAlertWith(message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func uploadNewEmployeeToServer() {
        let newEmployee = createEmployee()
        databaseConnection().loadNewEmployeeToServer(employee: newEmployee)
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        do {
            try isDataValid()
            uploadNewEmployeeToServer()
            progressView.show(for: self) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        catch let error {
            handleError(error: error)
        }
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
