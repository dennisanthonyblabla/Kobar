//
//  Battle+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

struct BattleWrapper: Decodable {
    let battle: BattleWithUserWrapper
    
    func toBattle() -> Battle { battle.toBattle() }
}

struct BattleWithUserWrapper: Decodable {
    let id: String
    let inviteCode: String
    let problem: Problem?
    let users: [UserWrapper]
    let startTime: String
    let endTime: String
    
    func toBattle() -> Battle {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFractionalSeconds
        return Battle(
            id: id,
            inviteCode: inviteCode,
            problem: problem,
            users: users.map { $0.user },
            startTime: dateFormatter.date(from: startTime) ?? Date.init(timeIntervalSince1970: 0),
            endTime: dateFormatter.date(from: endTime) ?? Date.init(timeIntervalSince1970: 0))
    }
}
