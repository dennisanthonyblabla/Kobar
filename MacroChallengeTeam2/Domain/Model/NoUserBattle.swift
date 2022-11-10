//
//  StartedBattle.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

struct NoUserBattle {
    let id: String
    let inviteCode: String
    let problem: Problem?
    let startTime: Date
    let endTime: Date
    
    func join(with battle: Battle) -> Battle {
        Battle(
            id: id,
            inviteCode: inviteCode,
            problem: problem,
            users: battle.users,
            startTime: startTime,
            endTime: endTime)
    }
}
