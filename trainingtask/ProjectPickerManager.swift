import UIKit

class ProjectPickerManager: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
 
    private var numberOfComponents = 1
    
    weak var delegate: ProjectPickerManagerDelegate?
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return databaseConnection().loadProjectsCountFromServer()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let name = projectNameForRow(at: row)
        return name
    }
    
    func projectNameForRow(at row: Int) -> String {
        let project = databaseConnection().loadProjectFromServer(at: row)
        let name = project.getName()
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = projectNameForRow(at: row)
        delegate?.valueDidChange(newValue: name)
    }
    
}
