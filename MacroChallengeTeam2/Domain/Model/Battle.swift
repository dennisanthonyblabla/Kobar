//
//  Battle.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct Battle: Identifiable, Decodable {
    let id: String
    let inviteCode: String
    let problem: Problem?
    let users: [User]
    let startTime: Date
    let endTime: Date
}
