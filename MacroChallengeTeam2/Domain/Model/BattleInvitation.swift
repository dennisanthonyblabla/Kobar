//
//  BattleInvitaion.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct BattleInvitation: Identifiable, Codable {
    let id: String
    let userId: String
    let inviteCode: String
}
