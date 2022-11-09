//
//  SocketHandler.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

// TODO: @salman implement abstraction for socket handler
class SocketIODataSource: WebSocketService {
    var socketManager: SocketManager
    var socketClient: SocketIOClient
    
    var onConnect: (() -> Void) = {}
    var onIdExchanged: ((User) -> Void) = { _ in }
    var onBattleInvitation: ((BattleInvitation) -> Void) = { _ in }

    init(url: URL?) {
        guard let url = url else {
            fatalError("Invalid socket URL!")
        }
        
        socketManager = SocketManager(socketURL: url, config: [.log(true), .compress])
        socketClient = socketManager.socket(forNamespace: "/battle")
    }

    func connect(token: String) {
        socketClient.on(clientEvent: .connect) { [weak self] _, _ in
            self?.onConnect()
        }

        socketClient.on("idExchanged") { [weak self] data, _ in
            do {
                let user: User = try SocketParser.convert(data: data[0])
                self?.onIdExchanged(user)
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.on("battleInvitationCreated") { [weak self] data, _ in
            do {
                let battleInvitation: BattleInvitation = try SocketParser.convert(data: data[0])
                self?.onBattleInvitation(battleInvitation)
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.connect(withPayload: ["token": "Bearer \(token)"])
    }
    
    func emitExchangeIdEvent(data: ExchangeIdDto) {
        socketClient.emit("exchangeId", data)
    }
    
    func emitCreateBattleInvitationEvent(data: CreateBattleInvitationDto) {
        socketClient.emit("createBattleInvitation", data)
    }

    func disconnect() {
        socketClient.disconnect()
    }
}


// func emitCreateBattleInvitationEvent(data: CreateBattleInvitationDto) {
//     mSocket.emit("createBattleInvitation", data)
// }
//
// func onBattleInvitationCreated(_ callback: @escaping(BattleInvitation) -> Void) {
//     mSocket.on("battleInvitationCreated") { dataArray, _ -> Void in
//         guard let data = dataArray.first else {return}
//
//         if let battleInvitation: BattleInvitation = try? SocketParser.convert(data: data) {
//             callback(battleInvitation)
//         }
//     }
// }
 
