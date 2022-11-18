//
//  BattleEvaluation.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct BattleEvaluation: Identifiable, Codable {
    let id: String
    let userId: String
    let correctness: Int
    let performance: Double
    let time: Double
    
    static func empty() -> BattleEvaluation {
        BattleEvaluation(
            id: "",
            userId: "",
            correctness: 0,
            performance: 0.0,
            time: 0.0)
    }
}
