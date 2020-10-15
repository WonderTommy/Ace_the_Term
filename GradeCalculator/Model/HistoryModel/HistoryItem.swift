//
//  HistoryItem.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-23.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct HistoryItem: Identifiable {
    var id: Int
    var time: String
    var subject: Subject
    
    var totalScore: String {
        get {
            return subject.totalScore
        }
    }
    
    var totalWeight: String {
        get {
            return subject.totalWeight
        }
    }
    
    init(id: Int, subject: Subject) {
        self.id = id
        self.subject = subject
        
        let date = Date()
        let calendar = Calendar.current
        
        let hour = String(calendar.component(.hour, from: date))
        let minute = String(calendar.component(.minute, from: date))
        let second = String(calendar.component(.second, from: date))
        let year = String(calendar.component(.year, from: date))
        let month = String(calendar.component(.month, from: date))
        let day = String(calendar.component(.day, from: date))
        self.time = "\(hour):\(minute):\(second) \(year).\(month).\(day)"
    }
}
