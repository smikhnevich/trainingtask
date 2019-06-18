import UIKit

class MainMenuViewController: UIViewController, MenuHandlerDelegate {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
    private var menuHandler = MenuManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuTableView.delegate = menuHandler
        mainMenuTableView.dataSource = menuHandler
        menuHandler.delegate = self
    }

    func shouldPerformSegue(_ menuHandler: MenuManager, segueIdentifier: String) {
        self.performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
}

