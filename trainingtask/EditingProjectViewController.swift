import UIKit

class EditingProjectViewController: UIViewController {
    
    
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectDiscription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func readyPressed(_ sender: Any) {
        if let text = projectName.text {
            if !text.isEmpty {
                //добавить сохранение данных
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
