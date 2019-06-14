import Foundation

protocol EmployeesManagerDelegate: class {
    func shouldPerformSegueWith(identifier: String, for employee: Employee? )
    func shouldRemoveRowAt(indexPath: IndexPath)
}
