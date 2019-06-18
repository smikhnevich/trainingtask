import UIKit

class StateInputField: UIView, TaskEditorToolBarDelegate, UITextFieldDelegate, StatePickerManagerDelegate {

    @IBOutlet weak var stateInputField: UITextField!
    
    private let nibName = "StateInputField"
    private var statePicker = StatePickerView()
    private var statePickerManager = StatePickerManager()
    private var toolBar = StateInputToolBar()
    private let toolBarHeight = CGFloat(40)
    
    private let states = ["В процессе", "Завершена", "Не начата", "Отложена"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStatePicker()
        setUpToolBar()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpStatePicker()
        setUpToolBar()
        setUp()
    }
    
    private func setUpToolBar() {
        toolBar = StateInputToolBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: toolBarHeight))
        toolBar.delegate = self
    }
    
    func setUpStatePicker() {
        statePicker.delegate = statePickerManager
        statePicker.dataSource = statePickerManager
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
        stateInputField.inputAccessoryView = toolBar
        statePickerManager.delegate = self
        stateInputField.delegate = self
        addSubview(view)
    }
    
    func readyButtonPressed() {
        stateInputField.resignFirstResponder()
    }
    
    func switchToList() {
        stateInputField.resignFirstResponder()
        stateInputField.inputView = statePicker
        stateInputField.text = statePickerManager.stateForRow(at: 0)
        stateInputField.becomeFirstResponder()
    }
    
    func switchToKeyboard() {
        stateInputField.resignFirstResponder()
        stateInputField.text?.removeAll()
        stateInputField.inputView = nil
        stateInputField.becomeFirstResponder()
    }
    
    func valueChanged(newValue: String) {
        stateInputField.text = newValue
    }
    
    func setState(state: String) {
        stateInputField.text = state
    }
    
    func state() throws -> String {
        guard let text = stateInputField.text else{
            throw TaskEditingErrors.noState
        }
        guard !text.isEmpty else {
            throw TaskEditingErrors.noState
        }
        guard states.contains(text) else {
            throw TaskEditingErrors.wrongState
        }
        return text
    }
    
}
