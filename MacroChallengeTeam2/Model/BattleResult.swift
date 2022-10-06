//
//  BattleResult.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct BattleResult: Identifiable, Codable {
    let id: UUID
    let battleId: UUID
    let winnerId: UUID
    let score: Int
    let evaluation: BattleEvaluation
}
