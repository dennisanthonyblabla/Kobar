//
//  SocketHandler.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

// TODO: @salman implement abstraction for socket handler
// TODO: @salman ini socket handler cuma bisa observe dari 1 client (UI / ViewModel / etc.)
class SocketIODataSource: WebSocketService {
    var socketManager: SocketManager
    var socketClient: SocketIOClient
    
    var onConnect: (() -> Void) = {}
    var onIdExchanged: ((User) -> Void) = { _ in }
    var onBattleInvitation: ((BattleInvitation) -> Void) = { _ in }
    var onBattleFound: ((Battle) -> Void) = { _ in }
    var onBattleRejoined: ((Battle) -> Void) = { _ in }
    var onBattleStarted: ((Battle) -> Void) = { _ in }
    var onBattleCanceled: (() -> Void) = {}

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
        
        socketClient.on("opponentFound") { [weak self] data, _ in
            do {
                let wrapper: BattleWrapper = try SocketParser.convert(data: data[0])
                self?.onBattleFound(wrapper.toBattle())
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.on("battleJoined") { [weak self] data, _ in
            do {
                let wrapper: BattleWrapper = try SocketParser.convert(data: data[0])
                self?.onBattleFound(wrapper.toBattle())
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.on("battleRejoined") { [weak self] data, _ in
            do {
                let wrapper: BattleWrapper = try SocketParser.convert(data: data[0])
                self?.onBattleRejoined(wrapper.toBattle())
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.on("battleStarted") { [weak self] data, _ in
            do {
                let wrapper: BattleWrapper = try SocketParser.convert(data: data[0])
                self?.onBattleStarted(wrapper.toBattle())
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
        
        socketClient.on("opponentRejoined") { _, _ in }
        
        socketClient.on("waitingForOpponent") { _, _ in }
        
        socketClient.on("battleCanceled") { [weak self] _, _ in
            self?.onBattleCanceled()
        }
        
        socketClient.connect(withPayload: ["token": "Bearer \(token)"])
    }
    
    func emitExchangeIdEvent(data: ExchangeIdDto) {
        socketClient.emit("exchangeId", data)
    }
    
    func emitCreateBattleInvitationEvent(data: CreateBattleInvitationDto) {
        socketClient.emit("createBattleInvitation", data)
    }
    
    func emitJoinBattleEvent(data: JoinBattleDto) {
        socketClient.emit("joinBattle", data)
    }
    
    func emitCancelBattleEvent(data: CancelBattleDto) {
        socketClient.emit("cancelBattle", data)
    }

    func emitReadyBattleEvent(data: ReadyBattleDto) {
        socketClient.emit("readyBattle", data)
    }

    func disconnect() {
        socketClient.disconnect()
    }
}
