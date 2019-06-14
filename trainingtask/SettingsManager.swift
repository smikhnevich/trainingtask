import Foundation

class SettingsManager {
    
    
    private var url = String()
    private var maxLinesNumber = Int()
    private var defaultDaysNumber = Int()
    
    private var keyForURL = "url"
    private var keyForMaxLinesNumber = "maxLinesNumber"
    private var keyForDefaultDaysNumber = "defaultDaysNumber"
    
    init() {
        loadSettings()
    }
    
    func returnURL() -> String {
        return url
    }
    
    func returnMaxLinesNumber() -> Int {
        return maxLinesNumber
    }
    
    func returnDefaultDaysNumber() -> Int {
        return defaultDaysNumber
    }
    
    private func loadSettings() {
        loadFromUserPreferenses()
    }
    
    private func loadFromDefaults() {
        //c файла
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
            self.maxLinesNumber = maxLinesNumber
        }
        else {
            return false
        }
        if let defaultDaysNumber = ud.object(forKey: keyForDefaultDaysNumber) as? Int{
            self.defaultDaysNumber = defaultDaysNumber
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
