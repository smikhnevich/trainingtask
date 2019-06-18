import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var stateIcon: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var projectName: UILabel!
    
    func projectNameIsHidden(_ value: Bool) {
        projectName.isHidden = value
    }
    
    func setTaskInfo(info: Task) {
        stateIcon.image = UIImage(named: info.getStatus())
        name.text = info.getName()
        projectName.text = info.getProjectName()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
