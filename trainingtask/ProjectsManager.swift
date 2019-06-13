import Foundation
import UIKit

class ProjectsManager: NSObject, ManagerProtocol {

    private let cellIdentifier = "project"
    
    private var database: Database?
    
    private func connectToDataServer() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    override init(){
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let projectsCount = connectToDataServer().loadProjectsCountFromServer()
        return projectsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProjectCell
        let project = connectToDataServer().loadProjectFromServer(at: indexPath.item)
        cell.setProjectInfo(info: project)
        return cell
    }
    
}
