import UIKit

class ProjectInputToolBar: UIView {
    
    let nibName = "ProjectInputToolBarView"
    
    weak var delegate: TaskEditorToolBarDelegate?
    
    @IBOutlet weak var switchButton: UIBarButtonItem!
    
    private var titleForKeyBoardState = "Список"
    private var titleForListState = "Клавиатура"
    
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
            delegate?.switchToList()
            switchButton.title = titleForListState
        }
        else {
            delegate?.switchToKeyboard()
            switchButton.title = titleForKeyBoardState
        }
        
    }
}
