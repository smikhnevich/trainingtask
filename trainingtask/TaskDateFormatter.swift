import UIKit

class TaskDateFormatter: DateFormatter {
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func daysToTimeInterval(days: Int) -> TimeInterval {
        return TimeInterval(days*24*60*60)
    }
    
    func addDefaultDaysNumber() -> Date{
        let daysNumber = 30
        let timeInterval = daysToTimeInterval(days: daysNumber)
        let endDate = Date(timeIntervalSinceNow: timeInterval)
        return endDate
    }
    
}

