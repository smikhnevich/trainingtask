import Foundation

class FileManager {
    
    private var fileName = "application.properties"
    private var fileExtension = "txt"
    private var keyForServerURL = "serverURL"
    private var keyForMaxRowsNumber = "maxRowsNumber"
    private var keyForDefaultDaysNumber = "defaultDaysNumber"
    private var pairsSeparator = "\n"
    private var keyAndValueSeparator = "="
    private var numberOfSpaces = 4
    
    private var fileContent = Dictionary<String, String>()
    
    init() {
        let path = getFilePath()
        let data = loadDataFromFile(path: path)
        loadValuesFrom(data: data)
    }
    
    private func getFilePath() -> URL {
        let filePath = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        return filePath!
    }
    
    private func loadDataFromFile(path: URL) -> String {
        let data = try? String(contentsOf: path)
        return data!
    }
    
    private func loadValuesFrom(data: String) {
        let keyValuePairs = data.components(separatedBy: pairsSeparator)
        for pair in keyValuePairs where pair != ""{
            let keyAndValue = pair.components(separatedBy: keyAndValueSeparator)
            let key = removeSpaces(data: keyAndValue[0])
            let value = keyAndValue[1]
            fileContent[key] = value
        }
    }
    
    private func removeSpaces(data: String) -> String {
        var newString = data
        newString.removeFirst(numberOfSpaces)
        return newString
    }
    
    func getServerURL() -> String {
        let serverURL = fileContent[keyForServerURL]!
        return serverURL
    }
    
    func getMaxRowsNumber() -> Int {
        let maxRowsNumber = Int(fileContent[keyForMaxRowsNumber]!)!
        return maxRowsNumber
    }
    
    func getDefaultDaysNumber() -> Int {
        let defaultDaysNumber = Int(fileContent[keyForDefaultDaysNumber]!)!
        return defaultDaysNumber
    }
}
