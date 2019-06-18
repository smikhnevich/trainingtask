import Foundation
import UIKit

class Task{
    
    private var name: String
    private var projectName: String
    private var numberOfNeededHours: Int
    private var startDate: Date
    private var endDate: Date
    private var status: String
    private var executor: String
    private var index: Int
    private static var indexCounter = 0
    
    init(name: String,
         projectName: String,
         numberOfNeededHours: Int,
         startDate: Date,
         endDate: Date,
         status: String,
         executor: String)
    {
        self.name = name
        self.projectName = projectName
        self.numberOfNeededHours = numberOfNeededHours
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.executor = executor
        index = Task.indexCounter
        Task.indexCounter += 1
    }
    
    func getName() -> String {
        return name
    }
    
    func getProjectName() -> String {
        return projectName
    }
    
    func getNumberOfHours() -> Int {
        return numberOfNeededHours
    }
    
    func getStartDate() -> Date {
        return startDate
    }
    
    func getEndDate() -> Date {
        return endDate
    }
    
    func getStatus() -> String {
        return status
    }
    
    func getExecutor() -> String {
        return executor
    }
    
    func set(name: String) {
        self.name = name
    }
    
    func set(projectName: String) {
        self.projectName = projectName
    }
    
    func set(numberOfNeededHours: Int) {
        self.numberOfNeededHours = numberOfNeededHours
    }
    
    func set(startDate: Date) {
        self.startDate = startDate
    }
    
    func set(endDate: Date) {
        self.endDate = endDate
    }
    
    func set(status: String) {
        self.status = status
    }
    
    func set(executor: String) {
        self.executor = executor
    }
    
    static func == (left: Task, right: Task) -> Bool {
        if left.index == right.index {
            return true
        }
        else {
            return false
        }
    }

}

