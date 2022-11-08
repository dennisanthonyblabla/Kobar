//
//  SocketHandler.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

class SocketHandler: NSObject {
    static let sharedInstance = SocketHandler()
    let socket = SocketManager(socketURL: URL(string: "http://kobar.up.railway.app")!, config: [.log(true), .compress])
    var mSocket: SocketIOClient!

    override init() {
        super.init()
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
        mSocket.on("idExchanged") { (dataArray, ack) -> Void in
            guard let userId = dataArray[0] as? String else {return}
            callback(userId)
        }
    }
    
    func emitCreateBattleInvitationEvent(data: CreateBattleInvitationDto) {
        mSocket.emit("createBattleInvitation", data)
    }
    
    func onBattleInvitationCreated(_ callback: @escaping(BattleInvitation) -> Void) {
        mSocket.on("battleInvitationCreated") { (dataArray, ack) -> Void in
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
