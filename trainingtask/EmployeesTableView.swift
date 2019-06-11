import UIKit

class EmployeesTableView: UITableView {
    
    private let cellIdentifier =  "employee"
    private let nibName = "EmployeeCell"
    
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
