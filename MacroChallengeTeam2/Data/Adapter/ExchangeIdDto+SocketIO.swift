//
//  ExchangeIdDto+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

extension ExchangeIdDto: SocketData {
    func socketRepresentation() -> SocketData {
        return ["auth0Id", auth0Id]
    }
}
