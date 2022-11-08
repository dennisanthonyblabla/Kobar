//
//  ReadyBattleDto.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

struct ReadyBattleDto: SocketData {
    
    let userId: String
    let battleId: String

}
