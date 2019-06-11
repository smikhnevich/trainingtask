import UIKit

class EditingTasksViewController: UIViewController {
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var tasksProjectName: UIPickerView!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var status: UIPickerView!
    @IBOutlet weak var executor: UIPickerView!
    
    let dateFormatter = TaskDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        //для отключения возможности взаимодействия
        //tasksProjectName.isUserInteractionEnabled = false
    }
    
    func setUp() {
        startDate.datePickerMode = .date
        endDate.datePickerMode = .date
        startDate.setDate(Date(), animated: true)
        let defaultEndDate = dateFormatter.addDefaultDaysNumber()
        endDate.setDate(defaultEndDate, animated: true)
    }
    
    
    
}
