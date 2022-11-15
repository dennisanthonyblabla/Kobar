//
//  Battle.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct Battle: Equatable {
    let id: String
    let inviteCode: String
    let problem: Problem?
    let users: [User]
    let startTime: Date
    let endTime: Date
    
    static func empty() -> Battle {
        Battle(
            id: "",
            inviteCode: "",
            problem: nil,
            users: [],
            startTime: Date.now,
            endTime: Date.now)
    }
}
