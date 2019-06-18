import UIKit

class DefaultToolBar: UIView {
    
    private let nibName = "DefaultToolBarView"
    
    weak var readyButtonDelegate: BarButtonItemDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        let view = loadFromNib()
        addSubview(view)
    }

    private func loadFromNib() -> UIView {
        var view = UIView()
        if let viewFromNib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view = viewFromNib
        }
        return view
    }
    @IBAction func readyPressed(_ sender: Any) {
        readyButtonDelegate?.readyPressed()
    }
    

}
