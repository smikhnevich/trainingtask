import UIKit

class ProjectInputField: UIView, TaskEditorToolBarDelegate, ProjectPickerManagerDelegate {
    
    private let nibName = "ProjectInputField"
    
    @IBOutlet weak var projectInputField: UITextField!
    private var toolBar = ProjectInputToolBar()
    private var projectPicker = ProjectPickerView()
    private var projectPickerManager = ProjectPickerManager()
    
    private var toolBarHeight = CGFloat(40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpProjectPicker()
        setUpToolBar()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpProjectPicker()
        setUpToolBar()
        setUp()
    }
    
    private func setUpToolBar() {
        toolBar = ProjectInputToolBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: toolBarHeight))
        toolBar.delegate = self
    }
    
    func setUpProjectPicker() {
        projectPicker.delegate = projectPickerManager
        projectPicker.dataSource = projectPickerManager
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
        projectInputField.inputAccessoryView = toolBar
        projectPickerManager.delegate = self
        addSubview(view)
    }
    
    func readyButtonPressed() {
        projectInputField.resignFirstResponder()
    }
    
    func switchToList() {
        projectInputField.resignFirstResponder()
        projectInputField.inputView = projectPicker
        projectInputField.text = projectPickerManager.projectNameForRow(at: 0)
        projectInputField.becomeFirstResponder()
    }
    
    func switchToKeyboard() {
        projectInputField.resignFirstResponder()
        projectInputField.text?.removeAll()
        projectInputField.inputView = nil
        projectInputField.becomeFirstResponder()
    }
    
    func valueDidChange(newValue: String) {
        projectInputField.text = newValue
    }
    
    func setProjectName(name: String) {
        projectInputField.text = name
    }
    
    func projectName() -> String? {
        return projectInputField.text
    }
    
}
