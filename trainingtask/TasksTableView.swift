import UIKit

class TasksTableView: UITableView {
    
    private let cellIdentifier = "task"
    private let cellNibName = "TaskCell"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp(){
        tableFooterView = UIView(frame: CGRect.null)
        register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
}
