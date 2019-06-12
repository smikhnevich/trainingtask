import UIKit

class DateEnteringField: UIView, UITextFieldDelegate, DatePickerToolBarDelegate {
    
    @IBOutlet weak var dateInputField: UITextField!
    
    private var nibName = "DateEnteringField"
    private let heightForToolBar = CGFloat(35)
    
    private let datePickerView = UIDatePicker()
    private var toolBar = DatePickerToolBar()
    private var barButtonItem = UIBarButtonItem()
    private var dateFormatter = TaskDateFormatter()
    
    weak var delegate: DateEnteringFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpToolBar()
        setUp()
    }
    
    func selectedDate() -> Date {
        return datePickerView.date
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
        dateInputField.delegate = self
        toolBar.delegate = self
        dateInputField.inputAccessoryView = toolBar
        addSubview(view)
    }
    
    private func setUpToolBar() {
        toolBar = DatePickerToolBar(frame: CGRect(x: 0, y: 0, width: bounds.width, height: heightForToolBar))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateInputField.resignFirstResponder()
        return true
    }
    
    func readyButtonPressed() {
        dateInputField.resignFirstResponder()
    }
    
    func switchToDatePicker() {
        dateInputField.resignFirstResponder()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        dateInputField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(valueChanged), for: UIControl.Event.valueChanged)
        dateInputField.becomeFirstResponder()
    }
    
    func switchToKeyBoard() {
        dateInputField.resignFirstResponder()
        dateInputField.inputView = nil
        dateInputField.becomeFirstResponder()
    }
    
    @objc func valueChanged(){
        let date = datePickerView.date
        let stringDate = dateFormatter.string(from: date)
        dateInputField.text = stringDate
    }
    
}
