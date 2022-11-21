//
//  BattleInvitaion.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct BattleInvitation: Equatable {
    let id: String
    let userId: String
    let inviteCode: String
}

extension BattleInvitation: Decodable {}
