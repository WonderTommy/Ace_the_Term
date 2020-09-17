//
//  CalculatorModel.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-03.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct CalculatorModel {
    var subjects: Array<Subject> = Array<Subject>()
    
    private var lastSubjectId: Int = 0
    
    init() {
        self.addSubject(title: "CS 135", items: nil)
        self.subjects[0].addItem(name: "Assignment 1", points: 20, fullPoints: 25, weight: 10)
        self.subjects[0].addItem(name: "Assignment 2", points: 17.222222, fullPoints: 25, weight: 10)
        self.subjects[0].addItem(name: "Assignment 3", points: 23, fullPoints: 25, weight: 10)
        self.subjects[0].addItem(name: "Midterm", points: 36, fullPoints: 40, weight: 30)
        self.subjects[0].addItem(name: "Final", points: 79, fullPoints: 100, weight: 40)
        self.addSubject(title: "CS 136", items: nil)
        self.subjects[1].addItem(name: "Assignment 1", points: 20, fullPoints: 25, weight: 10)
        self.subjects[1].addItem(name: "Assignment 2", points: 17.222222, fullPoints: 25, weight: 10)
        self.subjects[1].addItem(name: "Assignment 3", points: 23, fullPoints: 25, weight: 10)
        self.subjects[1].addItem(name: "Midterm", points: 36, fullPoints: 40, weight: 30)
        self.addSubject(title: "MATH 136", items: nil)
        self.subjects[2].addItem(name: "Assignment 1", points: 20, fullPoints: 25, weight: 10)
        self.subjects[2].addItem(name: "Assignment 2", points: 17.222222, fullPoints: 25, weight: 10)
        self.subjects[2].addItem(name: "Assignment 3", points: 23, fullPoints: 25, weight: 10)
        self.subjects[2].addItem(name: "Midterm", points: 36, fullPoints: 40, weight: 30)
        self.subjects[2].addItem(name: "Midterm 2", points: 39, fullPoints: 40, weight: 30)
        self.subjects[2].addItem(name: "Final", points: 79, fullPoints: 100, weight: 40)
    }
    
    mutating public func addSubject(title: String, items: Array<Item>?) {
        let newSubjects = Subject(id: lastSubjectId, title: title, items: items ?? Array<Item>())
        self.subjects.append(newSubjects)
        lastSubjectId += 1
    }
    
    mutating public func removeSubject(removeSubject: Subject) {
        var counter = 0
        for subject in self.subjects {
            if (subject.id == removeSubject.id) {
                self.subjects.remove(at: counter)
                break;
            } else {
                counter += 1
            }
        }
    }
    
    mutating public func removeSubject(at index: Int) {
        self.subjects.remove(at: index)
    }
    
    mutating public func removeSubjects(at spots: [Int]) {
        let sortedSpots = spots.sorted().reversed()
        for index in sortedSpots {
            self.subjects.remove(at: index)
        }
    }
    
    mutating public func removeSubjects(at spots: [Bool]) {
        let originLength = spots.count
        for rawIndex in 0..<originLength {
            let index = originLength - 1 - rawIndex
            if spots[index] == true {
                self.subjects.remove(at: index)
            }
        }
    }
    
    mutating public func moveSubject(from source: Int, to destination: Int) {
        let temp = self.subjects[source]
        self.subjects.remove(at: source)
        self.subjects.insert(temp, at: destination)
    }
    
    mutating func addItemForSubject(targetSubject: Subject, name: String, points: Double, fullPoints: Double, weight: Double) {
        for index in 0..<subjects.count {
            if (self.subjects[index] == targetSubject) {
                self.subjects[index].addItem(name: name, points: points, fullPoints: fullPoints, weight: weight)
                break
            }
        }
    }
    
    mutating func removeItemsForSubject(targetSubject: Subject, at spots: [Int]) {
        for index in 0..<subjects.count {
            if (self.subjects[index] == targetSubject) {
                self.subjects[index].removeItems(at: spots)
               break
           }
        }
    }
    
    mutating func removeItemsForSubject(targetSubject: Subject, at spots: [Bool]) {
        for index in 0..<subjects.count {
            if (self.subjects[index] == targetSubject) {
                self.subjects[index].removeItems(at: spots)
                break
            }
        }
    }
    
    mutating func modifyItemForSubject(targetSubject: Subject, item: Item) {
        for index in 0..<subjects.count {
            if (self.subjects[index] == targetSubject) {
                self.subjects[index].modifyItem(modifyItem: item)
                break
            }
        }
    }
    
    mutating func moveItemForSubject(targetSubject: Subject, from source: Int, to destination: Int) {
        for index in 0..<subjects.count {
            if (self.subjects[index] == targetSubject) {
                self.subjects[index].moveItem(from: source, to: destination)
                break
            }
        }
    }
    
    
//    private var currentItems: Array<Item> = Array<Item>()
//
//    private var currentItemId = 0
//
//    init() {
//        self.addCurrentItem(name: "Assignment 1", points: 20, fullPoints: 25, weight: 10)
//        self.addCurrentItem(name: "Assignment 2", points: 17.222, fullPoints: 25, weight: 10)
//    }
//
//    mutating public func addCurrentItem(name: String, points: Double, fullPoints: Double, weight: Double) {
//        let newItem = Item(id: currentItemId, name: name, points: points, fullPoints: fullPoints, weight: weight)
//        currentItems.append(newItem);
//        currentItemId += 1;
//    }
//
//    mutating public func removeItem(removeItem: Item) {
//        var counter = 0
//        for item in currentItems {
//            if (item.id == removeItem.id) {
//                currentItems.remove(at: counter)
//                break;
//            } else {
//                counter += 1
//            }
//        }
//    }
//
//    public func getCurrentItems() -> Array<Item> {
//        return self.currentItems
//    }
}
