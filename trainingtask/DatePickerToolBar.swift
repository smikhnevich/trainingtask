import UIKit

class DatePickerToolBar: UIView {
    
    let nibName = "DatePickerToolBarView"

    weak var delegate: DatePickerToolBarDelegate?
    
    @IBOutlet weak var switchButton: UIBarButtonItem!
    
    private var titleForKeyBoardState = "Календарь"
    private var titleForDatePickerState = "Клавиатура"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func loadFromNib() -> UIView {
        var view = UIView()
        if let viewFromNib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view = viewFromNib
        }
        return view
    }
    
    func setUp() {
        let view = loadFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    @IBAction func readyButtonPressed(_ sender: Any) {
        delegate?.readyButtonPressed()
    }
    
    @IBAction func switchModeButtonPressed(_ sender: Any) {
        if switchButton.title == titleForKeyBoardState {
            delegate?.switchToDatePicker()
            switchButton.title = titleForDatePickerState
        }
        else {
            delegate?.switchToKeyBoard()
            switchButton.title = titleForKeyBoardState
        }
        
    }
    
    
    
    
}
