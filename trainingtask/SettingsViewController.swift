import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var URLTextfield: UITextField!
    @IBOutlet weak var MaxLinesNumberTextField: UITextField!
    @IBOutlet weak var DfltDaysNmbrTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLTextfield.text = "111"
        MaxLinesNumberTextField.text = "111"
        DfltDaysNmbrTextField.text = "111"
    }
    
}
