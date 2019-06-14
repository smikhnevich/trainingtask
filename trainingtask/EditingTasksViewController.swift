import UIKit

class EditingTasksViewController: UIViewController, DateEnteringFieldDelegate {
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var tasksProjectNameField: ProjectInputField!
    @IBOutlet weak var numberOfNeededHoursField: UITextField!
    @IBOutlet weak var startDatePicker: DateEnteringField!
    @IBOutlet weak var endDatePicker: DateEnteringField!
    @IBOutlet weak var statusInputField: UITextField!
    @IBOutlet weak var executorPicker: EmployeeInputField!
    
    let dateFormatter = TaskDateFormatter()
    
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
        taskNameField.text = task.name
        tasksProjectNameField.setProjectName(name: task.projectName)
        numberOfNeededHoursField.text = String(task.numberOfNeededHours)
        startDatePicker.setDate(date: task.startDate)
        endDatePicker.setDate(date: task.endDate)
        statusInputField.text = task.statusImage
        executorPicker.setEmployeeName(name: task.executor)
    }
    
    private func setInitialDate() {
        let startDate = Date()
        startDatePicker.setDate(date: startDate)
        let endDate = dateFormatter.addDefaultDaysNumberToDate(date: startDate)
        endDatePicker.setDate(date: endDate)
        
    }
    
    private func setDefaults() {
        let date = Date()
        let newDate = dateFormatter.addDefaultDaysNumberToDate(date: date)
        startDatePicker.setDate(date: date)
        endDatePicker.setDate(date: newDate)
    }
    
    
    private func prepareTask() -> Task {
        let taskName = taskNameField.text!
        let projectName = tasksProjectNameField.projectName()!
        let numberOfNeededHours = Int(numberOfNeededHoursField.text!)!
        let startDate = startDatePicker.date()
        let endDate = endDatePicker.date()
        let status = statusInputField.text!
        let executor = executorPicker.fullName()
        let task = Task(statusImage: status,
                        name: taskName,
                        projectName: projectName,
                        numberOfNeededHours: numberOfNeededHours,
                        startDate: startDate,
                        endDate: endDate,
                        executor: executor)
        return task
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
        loadTaskToServer()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    func endEditing(_ field: DateEnteringField) {
        //let date = startDatePicker.selectedDate()
        //let defaultEndDate = dateFormatter.addDefaultDaysNumberToDate(date: date)
        //endDatePicker.setDate(date: defaultEndDate)
    }
    
}
