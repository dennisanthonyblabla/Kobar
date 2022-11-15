//
//  StartedBattle+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

struct NoUserBattleWrapper: Decodable {
    private let battle: NoUserBattleWithChildWrappers
    
    func toBattle() -> NoUserBattle { battle.toBattle() }
}

private struct NoUserBattleWithChildWrappers: Decodable {
    let id: String
    let inviteCode: String
    let problem: Problem?
    let startTime: String
    let endTime: String
    
    func toBattle() -> NoUserBattle {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds
        ]
        
        let startDate = dateFormatter.date(from: startTime)
        let endDate = dateFormatter.date(from: endTime)

        return NoUserBattle(
            id: id,
            inviteCode: inviteCode,
            problem: problem,
            startTime: startDate ?? Date.init(timeIntervalSince1970: 0),
            endTime: endDate ?? Date.init(timeIntervalSince1970: 0))
    }
}
