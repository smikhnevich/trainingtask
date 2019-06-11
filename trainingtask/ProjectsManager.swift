import Foundation
import UIKit

class ProjectsManager: NSObject, ManagerProtocol {
    
    private var projects = [Project]()
    private let cellIdentifier = "project"
    
    override init(){
        for i in 0..<5 {
            let project = Project(name: "\(i)", discription: "\(i)")
            projects.append(project)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ProjectCell
        cell.setProjectInfo(info: projects[indexPath.item])
        return cell
    }
    
}
