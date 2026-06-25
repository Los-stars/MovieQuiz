//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Amir on 15.05.2026.
//

import Foundation

final class StatisticService{
    private let storage: UserDefaults = .standard
    
    private enum Keys: String {
        case gamesCount
        case bestGameCorrect
        case bestGameTotal
        case bestGameDate
        case totalCorrectAnswers
        case totalQuestionsAsked
    }
}

extension StatisticService: StatisticServiceProtocol{
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get{
            let bestGameCorrect = storage.integer(forKey: "BestGameCorrect")
            let bestGameTotal = storage.integer(forKey: "BestGameTotal")
            let bestGameDate = storage.object(forKey: "BestGameDate") as? Date ?? Date.distantPast
            return GameResult(correct: bestGameCorrect, total: bestGameTotal, date: bestGameDate)
        }set{
            storage.set(newValue.correct, forKey: "BestGameCorrect")
            storage.set(newValue.total, forKey: "BestGameTotal")
            storage.set(newValue.date, forKey: "BestGameDate")
        }
    }
    
    var totalAccuracy: Double {
        let totalCorrect = storage.integer(forKey: "totalCorrectAnswers")
        let totalQuestions = storage.integer(forKey: "totalQuestionsAsked")
        return (Double(totalCorrect) / Double(totalQuestions)) * 100.0
    }
    
    func store(correct count: Int, total amount: Int) {
        let newGamesCount = gamesCount + 1
        gamesCount = newGamesCount
        
        let newTotalCorrect = storage.integer(forKey: "totalCorrectAnswers") + count
        let newTotalQuestions = storage.integer(forKey: "totalQuestionsAsked") + amount
        
        UserDefaults.standard.set(newTotalCorrect, forKey: "totalCorrectAnswers")
        UserDefaults.standard.set(newTotalQuestions, forKey: "totalQuestionsAsked")
        
        let currentGame = GameResult(correct: count, total: amount, date: Date())
        let currentBest = bestGame
        
        if currentGame.isBetterThan(currentBest) {
            bestGame = currentGame
        }
    }
    
    
}
