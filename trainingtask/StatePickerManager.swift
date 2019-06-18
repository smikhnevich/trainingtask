import UIKit

class StatePickerManager: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

    private let states = ["В процессе", "Завершена", "Не начата", "Отложена"]
    private let numberOfComponents = 1
    
    weak var delegate: StatePickerManagerDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.valueChanged(newValue: states[row])
    }
    
    func stateForRow(at row: Int) -> String {
        return states[row]
    }
    
}
