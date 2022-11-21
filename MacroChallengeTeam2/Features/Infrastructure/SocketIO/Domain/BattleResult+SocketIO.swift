//
//  BattleResult+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 11/11/22.
//

import Foundation

class BattleResultWrapper: Decodable {
    let battleResult: BattleResult
    
    func toBattleResult() -> BattleResult { battleResult }
}
