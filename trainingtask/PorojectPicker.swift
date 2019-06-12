import UIKit

class ProjectPicker: UIPickerView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp(){
        //delegate = dataHandler
        //dataSource = dataHandler
    }
    
    
}
