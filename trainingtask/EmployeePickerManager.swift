import UIKit

class EmployeePickerManager: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let numberOfComponents = 1
    private let separator = " "
    
    weak var delegate: EmployeePickerManagerDelegate?
    
    private func databaseConnection() -> Database {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.databaseConnection
    }
    
    private func fullNameInString(employee: Employee) -> String {
        let lastName = employee.getLastName()
        let firstName = employee.getFirstName()
        let patronymic = employee.getPatronymic()
        return lastName + separator + firstName + separator + patronymic
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let number = databaseConnection().loadEmployeesCountFromServer()
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let employee = databaseConnection().loadEmployeeFromServer(at: row)
        let fullName = fullNameInString(employee: employee)
        return fullName
    }
    
    func employeeFullNameForRow(at row: Int) -> String {
        let employee = databaseConnection().loadEmployeeFromServer(at: row)
        let fullName = fullNameInString(employee: employee)
        return fullName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = employeeFullNameForRow(at: row)
        delegate?.valueChanged(newValue: name)
    }
    
}
