import UIKit

class ProgressView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let nibName = "ProgressView"
    private let frameForView = CGRect(x: 0, y: 0, width: 80, height: 80)
    //private let cornerRadius = 10
    
    private let delay = 0.1
    private let duration = 1.0
    private let options: UIView.AnimationOptions = .curveEaseOut
    private let toastLabelAlphaAtEndOfAnimation: CGFloat = 0.0
    private let toastLabelAlpha: CGFloat = 1.0

    private let offset = CGFloat(75)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func show(for viewController: UIViewController, with completion: @escaping () -> ()) {
        center = viewController.view.center
        self.alpha = toastLabelAlpha
        viewController.view.addSubview(self)
        activityIndicator.startAnimating()
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = self.toastLabelAlphaAtEndOfAnimation
        }, completion: {(isCompleted) in
            completion()
            self.activityIndicator.stopAnimating()
            self.removeFromSuperview()
        })
    }
    
    private func setUp() {
        let view = loadFromNib()
        self.frame = frameForView
        view.frame = frameForView
        addSubview(view)
    }
    
    private func loadFromNib() -> UIView {
        var view = UIView()
        if let viewFromNib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view = viewFromNib
        }
        return view
    }
    
    func indicatorStartAnimating() {
        activityIndicator.startAnimating()
    }
    
    func indicatorStopAnimating() {
        activityIndicator.stopAnimating()
    }
    
}
