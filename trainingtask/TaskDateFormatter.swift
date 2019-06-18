import UIKit

class TaskDateFormatter: DateFormatter {
    
    private let format = "dd.MM.yyyy"
    
    private func settingsConnection() -> SettingsManager {
        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        return appDelegate.settingsConnection
    }
    
    
    override init() {
        super.init()
        dateFormat = format
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func daysToTimeInterval(days: Int) -> TimeInterval {
        return TimeInterval(days*24*60*60)
    }
    
    func addDefaultDaysNumberToDate(date: Date) -> Date {
        let daysNumber = settingsConnection().returnDefaultDaysNumber()
        let timeInterval = daysToTimeInterval(days: daysNumber)
        let endDate = Date(timeInterval: timeInterval, since: date)
        return endDate
    }
    
}

