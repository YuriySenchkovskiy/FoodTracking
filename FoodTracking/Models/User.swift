//
//  User.swift
//  FoodTracking
//
//  Created by Елена Червоткина on 12.09.2020.
//  Copyright © 2020 noname. All rights reserved.
//

import Foundation

class User{
    
    static let shared = User()

    private init() {}
    
    var name: String = "Ivan"
    var weight: Float = 80
    
    var targetScores: Int = 15
    
    var dayScores : [Date : [(foodId: Int,  score: Int)]] = [
        Date().stripTime() : [(1, 3), (5, 1)]
    ]
    
    func addScore(date: Date, foodId: Int){
        if dayScores[date] != nil {
            let oldScore = dayScores[date]?.filter({$0.foodId == foodId}).first?.score ?? 0
            let foodScore = (foodId, oldScore + 1)
            dayScores[date] = dayScores[date]?.filter({$0.foodId != foodId})
            dayScores[date]?.append(foodScore)
        } else {
            dayScores[date] = [(foodId, 1)]
        }
    }
    
    func deleteScore(date: Date, foodId: Int){
        if dayScores[date] != nil {
            let oldScore = dayScores[date]?.filter({$0.foodId == foodId}).first?.score ?? 0
            let foodScore = (foodId, (oldScore > 0 ? (oldScore - 1) : 0) )
            dayScores[date] = dayScores[date]?.filter({$0.foodId != foodId})
            dayScores[date]?.append(foodScore)
        }
    }
    
    func getTotalScore(date: Date) -> Int {
        var total = 0
        let foods = Food.getFoods()
        if let currentDayScores = self.dayScores[date] {
            for score in currentDayScores {
                if let foodsScores = foods.filter( {$0.id == score.foodId} ).first?.scores {
                    total += foodsScores.prefix(score.score).reduce(0, +)
                }
            }
        }
        return total
    }
}

extension Date {
    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }
}
