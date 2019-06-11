import UIKit

class EditEmployeeViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var patronymic: UITextField!
    @IBOutlet weak var position: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        //сохранить данные
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
