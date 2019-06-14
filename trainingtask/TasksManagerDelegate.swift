import UIKit

protocol TasksManagerDelegate: class {
    func shouldPerformSegue(name: String, for task: Task)
    func shouldRemoveTableViewRow(indexPath: IndexPath)
}
