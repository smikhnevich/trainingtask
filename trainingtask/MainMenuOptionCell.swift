import UIKit

class MainMenuOptionCell: UITableViewCell {

    @IBOutlet weak var optionNameLabel: UILabel!
    
    func setOptionName(name: String) {
        optionNameLabel.text = name
    }
    
    private func setUpNameLabel(){
        optionNameLabel.textAlignment = .center
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
