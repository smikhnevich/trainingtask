import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var URLTextfield: UITextField!
    @IBOutlet weak var MaxLinesNumberTextField: UITextField!
    @IBOutlet weak var DfltDaysNmbrTextField: UITextField!
    
    private var settingsManager = SettingsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLTextfield.isUserInteractionEnabled = false
        MaxLinesNumberTextField.isUserInteractionEnabled = false
        DfltDaysNmbrTextField.isUserInteractionEnabled = false
        loadSettings()
    }
    
    private func loadSettings() {
        URLTextfield.text = settingsManager.returnURL()
        MaxLinesNumberTextField.text = String(settingsManager.returnMaxLinesNumber())
        DfltDaysNmbrTextField.text = String(settingsManager.returnDefaultDaysNumber())
    }
    
    
    
    
    
}
