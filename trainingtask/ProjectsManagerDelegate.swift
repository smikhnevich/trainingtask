import Foundation

protocol ProjectsManagerDelegate: class {
    func shouldPerformSegue(name: String, for project: Project)
    func shouldRemoveTableViewRow(indexPath: IndexPath)
}
