//
//  ReadyBattleDto+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

extension ReadyBattleDto: SocketData {
    func socketRepresentation() -> SocketData {
        ["userId": userId, "battleId": battleId]
    }
}
