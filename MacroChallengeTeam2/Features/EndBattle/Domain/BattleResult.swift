//
//  BattleResult.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct BattleResult: Equatable {
    let id: String
    let battleId: String
    let winnerId: String
    let isDraw: Bool
    let score: Int
    let evaluations: [BattleEvaluation]
    
    static func empty() -> BattleResult {
        BattleResult(
            id: "",
            battleId: "",
            winnerId: "",
            isDraw: false,
            score: 0,
            evaluations: [])
    }
}

extension BattleResult: Decodable {}
