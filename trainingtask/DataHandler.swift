import UIKit

class DataHandler: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let projects = ["Project1" ,"Project2", "Project3"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projects[row]
    }
    
}
