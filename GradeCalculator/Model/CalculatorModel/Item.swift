//
//  Item.swift
//  GradeCalculator
//
//  Created by Hao Li on 2020-08-09.
//  Copyright © 2020 Hao Li. All rights reserved.
//

import Foundation

struct Item: Identifiable, Equatable {
    var id: Int // for Identifiable
    var name: String
    var points: Double
    var fullPoints: Double
    var weight: Double
    var trueScore: Double {
        get {
            self.getTrueScore()
        }
        set { }
    }// points / fullPoints * weight
    var trueScorePercent: Double {
        get {
            self.getTrueScorePercentage()
//            round((17.222222 / 25) * 100)
        }
        set { }
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        print("item equatable operator triggered")
        return lhs.id == rhs.id
    }
    
    init(id: Int, name: String, points: Double, fullPoints: Double, weight: Double) {
        self.id = id
        self.name = name
        self.points = points
        self.fullPoints = fullPoints
        self.weight = weight
        self.trueScore = self.getTrueScore()
        self.trueScorePercent = self.getTrueScorePercentage()
    }
    
    private func getTrueScore() -> Double {
        if self.points == 0.0 || self.fullPoints == 0.0 || self.weight == 0.0 {
            return 0.0
        } else {
            return round((self.points / self.fullPoints * self.weight) * 10000) / 10000
        }
    }
    
    private func getTrueScorePercentage() -> Double {
        if self.points == 0.0 || self.fullPoints == 0.0 {
            return 0.0
        } else {
            return round((self.points / self.fullPoints * 100) * 10000) / 10000
        }
    }
}
