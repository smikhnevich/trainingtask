import Foundation

protocol MenuHandlerDelegate {
    func shouldPerformSegue(_ menuHandler: MenuManager, segueIdentifier: String)
}
