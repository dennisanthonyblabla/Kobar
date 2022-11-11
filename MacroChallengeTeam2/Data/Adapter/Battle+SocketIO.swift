//
//  Battle+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

struct BattleWrapper: Decodable {
    private let battle: BattleWithChildWrappers
    
    func toBattle() -> Battle { battle.toBattle() }
}

private struct BattleWithChildWrappers: Decodable {
    let id: String
    let inviteCode: String
    let problem: Problem?
    let users: [UserWrapper]
    let startTime: String
    let endTime: String
    
    func toBattle() -> Battle {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds
        ]
        
        let startDate = dateFormatter.date(from: startTime)
        let endDate = dateFormatter.date(from: endTime)
        
        return Battle(
            id: id,
            inviteCode: inviteCode,
            problem: problem,
            users: users.map { $0.toUser() },
            startTime: startDate ?? Date.init(timeIntervalSince1970: 0),
            endTime: endDate ?? Date.init(timeIntervalSince1970: 0))
    }
}
