import Foundation
import UIKit

class Employee {
    private var firstName: String
    private var lastName: String
    private var patronymic: String
    private var position: String
    private var index: Int
    private var tasks: [Task]
    private static var indexCounter = 0
    
    private let separator = " "
    
    init(firstName: String, lastName: String, patronymic: String, position: String, tasks: [Task]) {
        self.firstName = firstName
        self.lastName = lastName
        self.patronymic = patronymic
        self.position = position
        self.tasks = tasks
        index = Employee.indexCounter
        Employee.indexCounter += 1
    }
    
    func contains(task: Task) -> Bool {
        if tasks.contains(where: { (listTask) -> Bool in
                                    if listTask == task {
                                        return true
                                    }
                                    else{
                                        return false
                                    }
                        })
        {
            return true
        }
        else {
            return false
        }
    }
    
    func getFirstName() -> String {
        return firstName
    }
    
    func getLastName() -> String {
        return lastName
    }
    
    func getPatronymic() -> String {
        return patronymic
    }
    
    func getFullName() -> String {
        return lastName + separator + firstName + separator + patronymic
    }
    
    func getPosition() -> String {
        return position
    }
    
    func set(firstName: String) {
        self.firstName = firstName
    }
    
    func set(lastName: String) {
        self.lastName = lastName
    }
    
    func set(patronymic: String) {
        self.patronymic = patronymic
    }
    
    func set(position: String) {
        self.position = position
    }
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func remove(task: Task) {
        tasks.removeAll { (listTask) -> Bool in
                        if listTask == task {
                            return true
                        }
                        else {
                            return false
                        }
        }
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    static func == (left: Employee, right: Employee) -> Bool {
        if left.index == right.index {
            return true
        }
        else {
            return false
        }
    }

}
