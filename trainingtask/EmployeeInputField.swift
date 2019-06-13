import UIKit

class EmployeeInputField: UIView, EmployeePickerManagerDelegate, TaskEditorToolBarDelegate {

    private let nibName = "EmployeeNameInputFieldView"
    
    @IBOutlet weak var employeeInputField: UITextField!
    
    private let toolBarHeight = CGFloat(40)
    private var toolBar = EmployeeInputToolBar()
    private var employeePicker = EmployeePickerView()
    private var employeePickerManager = EmployeePickerManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpEmployeePicker()
        setUpToolBar()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpEmployeePicker()
        setUpToolBar()
        setUp()
    }

    private func loadFromNib() -> UIView {
        var view = UIView()
        if let viewFromNib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view = viewFromNib
        }
        return view
    }
    
    private func setUp() {
        let view = loadFromNib()
        view.frame = bounds
        employeePickerManager.delegate = self
        employeeInputField.inputAccessoryView = toolBar
        addSubview(view)
    }
    
    private func setUpToolBar() {
        toolBar = EmployeeInputToolBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: toolBarHeight))
        toolBar.delegate = self
    }
    
    private func setUpEmployeePicker() {
        employeePicker.delegate = employeePickerManager
        employeePicker.dataSource = employeePickerManager
    }
    
    func valueChanged(newValue: String) {
        employeeInputField.text = newValue
    }
    
    private func textInField() -> String {
        return employeeInputField.text!
    }
    
    func readyButtonPressed() {
        employeeInputField.resignFirstResponder()
    }
    
    func switchToList() {
        employeeInputField.resignFirstResponder()
        employeeInputField.inputView = employeePicker
        employeeInputField.text = employeePickerManager.employeeFullNameForRow(at: 0)
        employeeInputField.becomeFirstResponder()
    }
    
    func switchToKeyboard() {
        employeeInputField.resignFirstResponder()
        employeeInputField.text?.removeAll()
        employeeInputField.inputView = nil
        employeeInputField.becomeFirstResponder()
    }
}
