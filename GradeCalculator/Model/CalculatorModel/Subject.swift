//
//  Subject.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-13.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct Subject: Identifiable, Equatable {
    static func == (lhs: Subject, rhs: Subject) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var title: String
    var items: [Item]// Array<Item>
    private var lastItemId: Int = 0
    
    init(id: Int, title: String, items: Array<Item>?) {
        self.id = id
        self.title = title
        self.items = items ?? Array<Item>()
    }
    
    mutating public func addItem(name: String, points: Double, fullPoints: Double, weight: Double) {
        let newItem = Item(id: lastItemId, name: name, points: points, fullPoints: fullPoints, weight: weight)
        items.append(newItem);
        lastItemId += 1;
    }
    
    mutating public func removeItem(removeItem: Item) {
//        var counter = 0
//        for item in items {
//            if (item.id == removeItem.id) {
//                items.remove(at: counter)
//                break;
//            } else {
//                counter += 1
//            }
//        }
        for index in 0...items.count {
            if (items[index] == removeItem) {
                items.remove(at: index)
                break
            }
        }
    }
    
    mutating public func removeItems(at spots: [Int]) {
        let sortedSpots = spots.sorted().reversed()
        for index in sortedSpots {
            self.items.remove(at: index)
        }
    }
    
    mutating public func removeItems(at spots: [Bool]) {
        let originLength = spots.count
        for rawIndex in 0..<originLength {
            let index = originLength - 1 - rawIndex
            if (spots[index] == true) {
                self.items.remove(at: index)
            }
        }
    }
    
    mutating public func modifyItem(modifyItem: Item) {
        for index in 0..<items.count {
            if (items[index] == modifyItem) {
//                var newItem = modifyItem
//                newItem.id = lastItemId
//                lastItemId += 1
//                items[index] = newItem
                items[index] = modifyItem
                break
            }
        }
    }
    
    mutating public func moveItem(from source: Int, to destination: Int) {
        let temp = self.items[source]
        self.items.remove(at: source)
        self.items.insert(temp, at: destination)
    }
    
//    public func getItems() -> Array<Item> {
//        return self.items
//    }
//
//    public func getTitle() -> String {
//        return self.title
//    }
    
//    public func getId() -> Int {
//        return self.id
//    }
}
