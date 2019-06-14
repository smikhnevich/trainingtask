import UIKit

class DateEnteringField: UIView, TaskEditorToolBarDelegate {
    
    @IBOutlet weak var dateInputField: UITextField!
    
    private var nibName = "DateEnteringField"
    private let heightForToolBar = CGFloat(40)
    
    private let datePickerView = UIDatePicker()
    private var toolBar = DatePickerToolBar()
    private var barButtonItem = UIBarButtonItem()
    private var dateFormatter = TaskDateFormatter()
    
    weak var delegate: DateEnteringFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpToolBar()
        setUp()
        dateInputField.keyboardType = .decimalPad
    }
    
    func date() -> Date {
        let dateString = dateInputField.text
        let date = dateFormatter.date(from: dateString!)!
        return date
    }
    
    private func selectedDate() -> Date {
        if let dateString = dateInputField.text {
            if !dateString.isEmpty{
                let date = dateFormatter.date(from: dateString)
                return date!
            }
            else {
                return Date()
            }
        }
        else{
            return Date()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpToolBar()
        setUp()
        dateInputField.keyboardType = .decimalPad
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
        toolBar.delegate = self
        dateInputField.inputAccessoryView = toolBar
        addSubview(view)
    }
    
    private func setUpToolBar() {
        toolBar = DatePickerToolBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: heightForToolBar))
    }
    
    private func setDateFromDatePicker() {
        let date = datePickerView.date
        let stringDate = dateFormatter.string(from: date)
        dateInputField.text = stringDate
    }
    
    func readyButtonPressed() {
        if dateInputField.inputView != nil {
            setDateFromDatePicker()
        }
        delegate?.endEditing?(self)
        dateInputField.resignFirstResponder()
    }
    
    func switchToList() {
        dateInputField.resignFirstResponder()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        dateInputField.inputView = datePickerView
        setDate(date: Date())
        datePickerView.addTarget(self, action: #selector(valueChanged), for: UIControl.Event.valueChanged)
        dateInputField.becomeFirstResponder()
    }
    
    func switchToKeyboard() {
        dateInputField.resignFirstResponder()
        dateInputField.text?.removeAll()
        dateInputField.inputView = nil
        dateInputField.becomeFirstResponder()
    }
    
    func setDate(date: Date) {
        let stringDate = dateFormatter.string(from: date)
        dateInputField.text = stringDate
    }
    
    @objc func valueChanged(){
        let date = datePickerView.date
        let stringDate = dateFormatter.string(from: date)
        dateInputField.text = stringDate
    }
    
}
