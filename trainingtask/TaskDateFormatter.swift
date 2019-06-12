import UIKit

class TaskDateFormatter: DateFormatter {
    
    let format = "MMM d, yyyy"
    
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
    
    func addDefaultDaysNumberToDate(date: Date) -> Date{
        let daysNumber = 30
        let timeInterval = daysToTimeInterval(days: daysNumber)
        let endDate = Date(timeInterval: timeInterval, since: date)
        return endDate
    }
    
}

