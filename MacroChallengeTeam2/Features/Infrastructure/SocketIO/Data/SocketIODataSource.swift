//
//  SocketHandler.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation
import SocketIO

class SocketIODataSource {
    private let socketManager: SocketManager
    private let socketClient: SocketIOClient
    
    var onConnect: (() -> Void) = {}
    var onIdExchanged: ((User) -> Void) = { _ in }
    var onBattleInvitation: ((BattleInvitation) -> Void) = { _ in }
    var onBattleFound: ((Battle) -> Void) = { _ in }
    var onBattleRejoined: ((Battle) -> Void) = { _ in }
    var onBattleStarted: ((Battle) -> Void) = { _ in }
    var onBattleCanceled: (() -> Void) = {}
    var onCodeRan: ((RunCodeResult) -> Void) = { _ in }
    var onCodeSubmit: ((SubmitCodeResult) -> Void) = { _ in }
    var onBattleFinished: ((BattleResult) -> Void) = { _ in }

    init(url: URL?) {
        guard let url = url else {
            fatalError("Invalid socket URL!")
        }
        
        socketManager = SocketManager(socketURL: url, config: [.log(false), .compress])
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
        
        socketClient.on("opponentRejoined") { _, _ in }
        
        socketClient.on("opponentRunCode") { _, _ in }
        
        socketClient.on("opponentSubmittedCode") { _, _ in }
        
        socketClient.on("waitingForOpponent") { _, _ in }
        
        socketClient.on("battleCanceled") { [weak self] _, _ in
            self?.onBattleCanceled()
        }
        
        socketClient.on("codeRan") { [weak self] data, _ in
            do {
                let result: RunCodeResult = try SocketParser.convert(data: data[0])
                self?.onCodeRan(result)
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.on("codeSubmitted") { [weak self] data, _ in
            do {
                let result: SubmitCodeResult = try SocketParser.convert(data: data[0])
                self?.onCodeSubmit(result)
            } catch {
                print("Failed to parse")
            }
        }
        
        socketClient.on("battleFinished") { [weak self] data, _ in
            do {
                let wrapper: BattleResultWrapper = try SocketParser.convert(data: data[0])
                self?.onBattleFinished(wrapper.toBattleResult())
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
    
    func emitJoinBattleEvent(data: JoinBattleDto) {
        socketClient.emit("joinBattle", data)
    }
    
    func emitCancelBattleEvent(data: CancelBattleDto) {
        socketClient.emit("cancelBattle", data)
    }
    
    func emitReadyBattleEvent(data: ReadyBattleDto) {
        socketClient.emit("readyBattle", data)
    }
    
    func emitRunCodeEvent(data: RunCodeDto) {
        socketClient.emit("runCode", data)
    }
    
    func emitSubmitCodeEvent(data: SubmitCodeDto) {
        socketClient.emit("submitCode", data)
    }

    func disconnect() {
        socketClient.disconnect()
    }
}
