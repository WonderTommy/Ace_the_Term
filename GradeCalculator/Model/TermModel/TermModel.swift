//
//  TermModel.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-09-20.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct TermModel {
    var terms: Array<Term> = Array<Term>()
    init() {
        addTerm(title: "1A", subjects: nil)
        addTerm(title: "1B", subjects: nil)
        addTerm(title: "2A", subjects: nil)
        addTerm(title: "2B", subjects: nil)
        addTerm(title: "3A", subjects: nil)
        addTerm(title: "3B", subjects: nil)
        addTerm(title: "4A", subjects: nil)
        addTerm(title: "4B", subjects: nil)
    }
    
    private var lastTermId: Int = 0
    
    mutating public func addTerm(title: String, subjects: Array<Subject>?) {
        let newTerm = Term(id: lastTermId, title: title, subjects: subjects ?? Array<Subject>())
        terms.append(newTerm)
        lastTermId += 1
    }
    
    mutating public func removeTerm(removeTerm: Term) {
        var counter = 0
        for term in self.terms {
            if (term.id == removeTerm.id) {
                self.terms.remove(at: counter)
                break;
            } else {
                counter += 1
            }
        }
    }
    
    mutating public func removeTerm(at index: Int) {
        self.terms.remove(at: index)
    }
    
    mutating public func removeTerms(at spots: [Int]) {
        let sortedSpots = spots.sorted().reversed()
        for index in sortedSpots {
            self.terms.remove(at: index)
        }
    }
    
    mutating public func removeTerms(at spots: [Bool]) {
        let originLength = spots.count
        for rawIndex in 0..<originLength {
            let index = originLength - 1 - rawIndex
            if spots[index] == true {
                self.terms.remove(at: index)
            }
        }
    }
    
    mutating public func moveTerm(from source: Int, to destination: Int) {
        let temp = self.terms[source]
        self.terms.remove(at: source)
        self.terms.insert(temp, at: destination)
    }
    
    mutating public func addSubjectForTerm(targetTerm: Term, subject: Subject) {
        for index in 0..<terms.count {
            if terms[index] == targetTerm {
                terms[index].addSubject(newSubject: subject)
            }
        }
    }
    
    mutating public func addSubjectsForTerm(targetTerm: Term, subjects: [Subject]) {
        for index in 0..<terms.count {
            if terms[index] == targetTerm {
                terms[index].addSubjects(newSubjects: subjects)
            }
        }
    }
    
    mutating public func replaceBySubjectsForTerm(targetTerm: Term, subjects: [Subject]) {
        for index in 0..<terms.count {
            if terms[index] == targetTerm {
                terms[index].replaceBySubjects(newSubjects: subjects)
            }
        }
    }
}
