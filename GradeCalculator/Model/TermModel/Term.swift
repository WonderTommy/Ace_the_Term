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
    
    init(id: Int, title: String, subjects: Array<Subject>) {
        self.id = id
        self.title = title
        self.subjects = subjects
    }
    
    mutating public func addSubject(newSubject: Subject) {
        subjects.append(newSubject)
    }
    
    mutating public func addSubjects(newSubjects: [Subject]) {
        subjects.append(contentsOf: newSubjects)
    }
    
    mutating public func replaceBySubjects(newSubjects: [Subject]) {
        self.subjects = newSubjects
    }
}
