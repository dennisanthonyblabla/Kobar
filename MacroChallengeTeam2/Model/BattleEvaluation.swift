//
//  BattleEvaluation.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct BattleEvaluation: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let correctness: Int
    let performance: Int
    let time: Int
}
