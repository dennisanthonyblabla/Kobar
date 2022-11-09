//
//  Battle.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct Battle: Identifiable, Codable {
    let id: UUID
    let inviteCode: String
    let problemId: UUID
    let users: [User]
    let startTime: Date
    let endTime: Date
}
