//
//  CancelBattleDto+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

extension CancelBattleDto: SocketData {
    func socketRepresentation() -> SocketData {
        return ["battleId": battleId]
    }
}
