//
//  HistoryModel.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-23.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct HistoryModel {
    var records = Array<HistoryItem>()
    private var lastRecordId = 0
    
    init() {
//        records.append(HistoryItem(id: lastRecordId, time: Date(), subject: Subject(id: 0, title: "CS 135", items: nil)))
    }
    
    mutating public func addRecord(subject: Subject) {
        let newRecord = HistoryItem(id: lastRecordId, subject: subject)
        records.append(newRecord)
        lastRecordId += 1
    }
    
    
}
