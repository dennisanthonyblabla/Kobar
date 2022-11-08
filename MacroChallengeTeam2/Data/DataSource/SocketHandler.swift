//
//  SocketHandler.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

class SocketHandler: NSObject {
    var mSocket: SocketIOClient

    init(url: URL?) {
        guard let url = url else {
            fatalError("Invalid socket URL!")
        }
        
        let socket = SocketManager(socketURL: url, config: [.log(true), .compress])
        
        mSocket = socket.socket(forNamespace: "/battle")
    }

    func getSocket() -> SocketIOClient {
        return mSocket
    }

    func establishConnection(token: String) {
        mSocket.connect(withPayload: ["token": "Bearer \(token)"])
    }
    
    func emitExchangeIdEvent(data: ExchangeIdDto) {
        mSocket.emit("exchangeId", data)
    }
    
    func onIdExchangedEvent(_ callback: @escaping (String) -> Void) {
        mSocket.on("idExchanged") { dataArray, _ -> Void in
            guard let userId = dataArray[0] as? String else {return}
            callback(userId)
        }
    }
    
    func emitCreateBattleInvitationEvent(data: CreateBattleInvitationDto) {
        mSocket.emit("createBattleInvitation", data)
    }
    
    func onBattleInvitationCreated(_ callback: @escaping(BattleInvitation) -> Void) {
        mSocket.on("battleInvitationCreated") { dataArray, _ -> Void in
            guard let data = dataArray.first else {return}
            
            if let battleInvitation: BattleInvitation = try? SocketParser.convert(data: data) {
                callback(battleInvitation)
            }
        }
    }

    func closeConnection() {
        mSocket.disconnect()
    }
}
