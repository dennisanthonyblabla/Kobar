//
//  RunCodeDto+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

extension RunCodeDto: SocketData {
    func socketRepresentation() -> SocketData {
        return ["userId": userId, "battleId": battleId, "problemId": problemId, "code": code, "input": input]
    }
}
