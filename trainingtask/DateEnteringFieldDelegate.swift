import UIKit

@objc protocol DateEnteringFieldDelegate: class {
    @objc optional func resignFirstResponder()
    @objc optional func endEditing(_ field: DateEnteringField)
}
