import UIKit

class EditingTasksViewController: UIViewController, DateEnteringFieldDelegate {
    
    @IBOutlet weak var taskNameField: UIView!
    @IBOutlet weak var tasksProjectNamePicker: UIView!
    @IBOutlet weak var numberOfNeededHoursField: UIView!
    @IBOutlet weak var startDatePicker: DateEnteringField!
    @IBOutlet weak var endDatePicker: DateEnteringField!
    @IBOutlet weak var statusPicker: UIView!
    @IBOutlet weak var executorPicker: UIView!
    
    let dateFormatter = TaskDateFormatter()
    
    private var database: Database?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        //для отключения возможности взаимодействия
        //tasksProjectName.isUserInteractionEnabled = false
    }
    
    /*
    private func createNewTask() -> Task {
        let taskName = taskNameField.text!
        let taskSelectedRow = tasksProjectNamePicker.selectedRow(inComponent: 1)
        //добавить таск пикер и т.д
        return Task()
    }
    */
    
    private func loadNewTaskToServer() {
        //let newTask = createNewTask()
        //databaseConnection().loadNewTaskToServer(task: newTask)
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
        loadNewTaskToServer()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func endEditing(_ field: DateEnteringField) {
        let date = startDatePicker.selectedDate()
        let defaultEndDate = dateFormatter.addDefaultDaysNumberToDate(date: date)
        let dateString = dateFormatter.string(from: defaultEndDate)
        print(dateString)
    }
    
    
    
}
