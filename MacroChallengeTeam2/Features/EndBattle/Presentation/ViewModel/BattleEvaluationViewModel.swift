//
//  BattleEvaluationViewModel.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 20/11/22.
//

import Foundation

class BattleEvaluationViewModel {
    private let battleEvaluation: BattleEvaluation
    private let testCaseCount: Int
    
    init(_ battleEvaluation: BattleEvaluation, testCaseCount: Int) {
        self.battleEvaluation = battleEvaluation
        self.testCaseCount = testCaseCount
    }
    
    var codeCorrectNess: String {
        return "\(battleEvaluation.correctness)/\(testCaseCount)"
    }
    
    var codePerformance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return "\(formatter.string(for: battleEvaluation.performance) ?? "0") ms"
    }
    
    var time: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: battleEvaluation.time / 100) ?? ""
    }
}
