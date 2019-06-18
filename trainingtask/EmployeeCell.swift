import UIKit

class EmployeeCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var patronymicLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setEmployeeInfo(info: Employee) {
        firstNameLabel.text = info.getFirstName()
        lastNameLabel.text = info.getLastName()
        patronymicLabel.text = info.getPatronymic()
        positionLabel.text = info.getPosition()
    }
    
}
