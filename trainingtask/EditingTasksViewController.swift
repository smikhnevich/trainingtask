import UIKit

class EditingTasksViewController: UIViewController, DateEnteringFieldDelegate {
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var tasksProjectNameField: ProjectInputField!
    @IBOutlet weak var numberOfNeededHoursField: UITextField!
    @IBOutlet weak var startDatePicker: DateEnteringField!
    @IBOutlet weak var endDatePicker: DateEnteringField!
    @IBOutlet weak var stateInputField: StateInputField!
    @IBOutlet weak var executorPicker: EmployeeInputField!
    
    private let dateFormatter = TaskDateFormatter()
    private var errorMessages = TaskEditingErrorMessages()
    private let progressView = ProgressView()
    private var alertTitle = "Ошибка"
    private var alertActionTitle = "Ок"
    
    private var taskForEditing: Task?
    private var tasksProjectName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        if let projectName = tasksProjectName {
            setProjectName(name: projectName)
        }
        if let task = taskForEditing {
            initFromTask(task: task)
        }
        else {
            setInitialDate()
        }
    }
    
    func setTaskForEditing(task: Task) {
        taskForEditing = task
    }
    
    func setTasksProjectName(name: String) {
        tasksProjectName = name
    }
    
    private func setProjectName(name: String) {
        tasksProjectNameField.setProjectName(name: name)
        tasksProjectNameField.isUserInteractionEnabled = false
    }
    
    private func initFromTask(task: Task) {
        taskNameField.text = task.getName()
        tasksProjectNameField.setProjectName(name: task.getProjectName())
        numberOfNeededHoursField.text = String(task.getNumberOfHours())
        startDatePicker.setDate(date: task.getStartDate())
        endDatePicker.setDate(date: task.getEndDate())
        stateInputField.setState(state: task.getStatus())
        executorPicker.setEmployeeName(name: task.getExecutor())
    }
    
    private func setInitialDate() {
        let startDate = Date()
        startDatePicker.setDate(date: startDate)
        let endDate = dateFormatter.addDefaultDaysNumberToDate(date: startDate)
        endDatePicker.setDate(date: endDate)
    }
    
    private func setDefaults() {
        let date = Date()
        startDatePicker.setDate(date: date)
        let newDate = dateFormatter.addDefaultDaysNumberToDate(date: date)
        endDatePicker.setDate(date: newDate)
    }
    
    private func isDataValid() throws {
        guard taskNameField.text != "" else {
            throw TaskEditingErrors.noProjectName
        }
        guard tasksProjectNameField.projectName() != "" else {
            throw TaskEditingErrors.noProjectName
        }
        guard numberOfNeededHoursField.text != "" else {
            throw TaskEditingErrors.noNumberOfHours
        }
        guard Int(numberOfNeededHoursField.text!) != nil else {
            throw TaskEditingErrors.wrongNumberOfHours
        }
        let firstDate = try startDatePicker.date()
        let secondDate = try endDatePicker.date()
        if firstDate > secondDate {
            throw TaskEditingErrors.wrongDate
        }
        _ = try stateInputField.state()
    }
    
    private func prepareTask() -> Task {
        let taskName = taskNameField.text!
        let projectName = tasksProjectNameField.projectName()!
        let numberOfNeededHours = Int(numberOfNeededHoursField.text!)!
        let startDate = try! startDatePicker.date()
        let endDate = try! endDatePicker.date()
        let status = try! stateInputField.state()
        let executor = executorPicker.fullName()
        if taskForEditing != nil {
            taskForEditing?.set(name: taskName)
            taskForEditing?.set(projectName: projectName)
            taskForEditing?.set(numberOfNeededHours: numberOfNeededHours)
            taskForEditing?.set(startDate: startDate)
            taskForEditing?.set(endDate: endDate)
            taskForEditing?.set(status: status)
            taskForEditing?.set(executor: executor)
            return taskForEditing!
        }
        else {
            let task = Task(name: taskName,
                            projectName: projectName,
                            numberOfNeededHours: numberOfNeededHours,
                            startDate: startDate,
                            endDate: endDate,
                            status: status,
                            executor: executor)
            return task
        }
    }
    
    
    private func loadTaskToServer() {
        let newTask = prepareTask()
        databaseConnection().loadNewTaskToServer(task: newTask)
    }
    
    private func databaseConnection() -> Database{
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func setUp() {
        startDatePicker.delegate = self
    }
    
    @IBAction func saveAction(_ sender: Any) {
        do {
            try isDataValid()
            loadTaskToServer()
            progressView.show(for: self) {
                self.dismiss(animated: true, completion: nil)
            }
        }
        catch let error {
            handleError(error: error)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    func endEditing(_ field: DateEnteringField) {
        //let date = startDatePicker.selectedDate()
        //let defaultEndDate = dateFormatter.addDefaultDaysNumberToDate(date: date)
        //endDatePicker.setDate(date: defaultEndDate)
    }
    
    private func showAlertWith(message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func handleError(error: Error) {
        let convertedError = error as! TaskEditingErrors
        switch convertedError {
        case TaskEditingErrors.noTaskName:
            showAlertWith(message: errorMessages.noName)
        case TaskEditingErrors.noProjectName:
            showAlertWith(message: errorMessages.noProjectName)
        case TaskEditingErrors.noNumberOfHours:
            showAlertWith(message: errorMessages.noNumberOfHours)
        case TaskEditingErrors.wrongNumberOfHours:
            showAlertWith(message: errorMessages.wrongNumberOfHours)
        case TaskEditingErrors.noDate:
            showAlertWith(message: errorMessages.noDate)
        case TaskEditingErrors.wrongDate:
            showAlertWith(message: errorMessages.wrongDate)
        case TaskEditingErrors.noState:
            showAlertWith(message: errorMessages.noState)
        case TaskEditingErrors.wrongState:
            showAlertWith(message: errorMessages.wrongState)
        case TaskEditingErrors.noExecutor:
            showAlertWith(message: errorMessages.noExecutor)
        }
    }

}
