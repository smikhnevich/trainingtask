import Foundation

class SettingsManager {
    
    private var url = String()
    private var maxRowsNumber = Int()
    private var defaultDaysNumber = Int()
    private var fileManager = FileManager()
    
    private var keyForURL = "url"
    private var keyForMaxLinesNumber = "maxLinesNumber"
    private var keyForDefaultDaysNumber = "defaultDaysNumber"
    
    init() {
        if !loadFromUserPreferenses() {
            loadFromDefaults()
        }
    }
    
    func returnURL() -> String {
        return url
    }
    
    func returnMaxLinesNumber() -> Int {
        return maxRowsNumber
    }
    
    func returnDefaultDaysNumber() -> Int {
        return defaultDaysNumber
    }

    
    private func loadFromDefaults() {
        url = fileManager.getServerURL()
        maxRowsNumber = fileManager.getMaxRowsNumber()
        defaultDaysNumber = fileManager.getDefaultDaysNumber()
    }
    
    private func loadFromUserPreferenses() -> Bool {
        let ud = UserDefaults()
        if let url = ud.object(forKey: keyForURL) as? String{
            self.url = url
        }
        else{
            return false
        }
        if let maxLinesNumber = ud.object(forKey: keyForMaxLinesNumber) as? Int {
            self.maxRowsNumber = maxLinesNumber
        }
        else {
            return false
        }
        if let defaultDaysNumber = ud.object(forKey: keyForDefaultDaysNumber) as? Int{
            self.defaultDaysNumber = defaultDaysNumber
        }
        else{
            return false
        }
        return true
    }
    
    func saveSettings(url: String, maxLinesNumber: Int, defaultDaysNumber: Int) {
        let ud = UserDefaults()
        ud.set(url, forKey: keyForURL)
        ud.set(maxLinesNumber, forKey: keyForMaxLinesNumber)
        ud.set(defaultDaysNumber, forKey: keyForDefaultDaysNumber)
    }
    
    
}
