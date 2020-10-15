//
//  Term.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-20.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct Term: Identifiable, Equatable {
    static func == (lhs: Term, rhs: Term) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    
    var title: String
    var subjects: [Subject]
    
    var averageScore: String {
        get {
            let scores = subjects.map({ CalculationUtility.summationScore(items: $0.items) })
            var result = "0"
            if scores.count != 0 {
                let rounded = round((scores.reduce(0) { $0 + $1 }) / Double(scores.count) * 10000) / 10000
                result = "\(String(rounded))"
            }
            return result
        }
    }
    
    init(id: Int, title: String, subjects: Array<Subject>) {
        self.id = id
        self.title = title
        self.subjects = subjects
    }
    
    mutating public func addSubject(newSubject: Subject) {
        subjects.append(newSubject)
    }
    
    mutating public func addSubjects(newSubjects: [Subject]) {
        for newSubject in newSubjects {
            let index = subjectAlreadyExistAt(targetSubject: newSubject)
            print("duplicate at: ", index)
            if index >= 0 {
                subjects[index] = newSubject
            } else {
                subjects.append(newSubject)
            }
        }
    }
    
    mutating public func replaceBySubjects(newSubjects: [Subject]) {
        self.subjects = newSubjects
    }
    
    private func subjectAlreadyExistAt(targetSubject: Subject) -> Int {
        var result = -1
        for index in 0..<subjects.count {
            if subjects[index].title == targetSubject.title {
                result = index
                break
            }
        }
        return result
    }
}
