import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate, BarButtonItemDelegate {
    
    @IBOutlet weak var URLTextfield: UITextField!
    @IBOutlet weak var MaxLinesNumberTextField: UITextField!
    @IBOutlet weak var DfltDaysNmbrTextField: UITextField!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    private let editButtonTitle = "Ред."
    private let readyButtonTitle = "Готово"
    private var toolBar = DefaultToolBar()
    private let toolBarHeight = CGFloat(40)
    
    private func settingsConnection() -> SettingsManager {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.settingsConnection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLTextfield.isUserInteractionEnabled = false
        MaxLinesNumberTextField.isUserInteractionEnabled = false
        DfltDaysNmbrTextField.isUserInteractionEnabled = false
        URLTextfield.delegate = self
        MaxLinesNumberTextField.delegate = self
        DfltDaysNmbrTextField.delegate = self
        loadSettings()
        setUpToolBar()
    }
    
    private func loadSettings() {
        URLTextfield.text = settingsConnection().returnURL()
        MaxLinesNumberTextField.text = String(settingsConnection().returnMaxLinesNumber())
        DfltDaysNmbrTextField.text = String(settingsConnection().returnDefaultDaysNumber())
    }
    
    private func setUpToolBar() {
        toolBar = DefaultToolBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: toolBarHeight))
        toolBar.readyButtonDelegate = self
    }
    
    private func makeTextFieldsAvailable(_ value: Bool) {
        URLTextfield.isUserInteractionEnabled = value
        MaxLinesNumberTextField.isUserInteractionEnabled = value
        DfltDaysNmbrTextField.isUserInteractionEnabled = value
    }
    
    private func saveSettings() {
        let url = URLTextfield.text!
        let maxRowsNumber = Int(MaxLinesNumberTextField.text!)!
        let defaultDaysNumber = Int(DfltDaysNmbrTextField.text!)!
        settingsConnection().saveSettings(url: url, maxLinesNumber: maxRowsNumber, defaultDaysNumber: defaultDaysNumber)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case URLTextfield:
            textField.keyboardType = .default
        case MaxLinesNumberTextField:
            textField.keyboardType = .numberPad
        case DfltDaysNmbrTextField:
            textField.keyboardType = .numberPad
        default:
            return
        }
        textField.inputAccessoryView = toolBar
    }
    
    func readyPressed() {
        URLTextfield.resignFirstResponder()
        MaxLinesNumberTextField.resignFirstResponder()
        DfltDaysNmbrTextField.resignFirstResponder()
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        if editButton.title == editButtonTitle {
            makeTextFieldsAvailable(true)
            editButton.title = readyButtonTitle
        }
        else {
            makeTextFieldsAvailable(false)
            saveSettings()
            editButton.title = editButtonTitle
        }
    }
    
}
