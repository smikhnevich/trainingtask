import Foundation
import UIKit

class ProjectsTableView: UITableView {
    
    private let cellIdentifier =  "project"
    private let nibName = "ProjectCell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp(){
        tableFooterView = UIView(frame: CGRect.zero)
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
}
