//
//  StartBattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift


class BattleViewModel {
    private let socketService: SocketIODataSource
    private let user: User
    private let battle: Battle
    
    struct BattleState {
        let user: User
        let battle: Battle
        let status: BattleStatus
        
        init(_ user: User, _ battle: Battle, _ status: BattleStatus) {
            self.user = user
            self.battle = battle
            self.status = status
        }
    }
    
    enum BattleStatus {
        case pending
        case started
        case canceled
    }
    
    init(socketService: SocketIODataSource, user: User, battle: Battle) {
        self.socketService = socketService
        self.battle = battle
        self.user = user
    }
        
    func start() {
        socketService.emitReadyBattleEvent(
            data: ReadyBattleDto(userId: user.id, battleId: battle.id))
    }
    
    func cancel() {
        socketService.emitCancelBattleEvent(
            data: CancelBattleDto(battleId: battle.id))
    }
    
    func battleState() -> Observable<BattleState> {
        Observable<BattleState>.create { [weak self, user, battle] observer in
            observer.onNext(BattleState(user, battle, .pending))
            
            self?.socketService.onBattleCanceled = {
                observer.onNext(BattleState(user, battle, .canceled))
            }
            
            self?.socketService.onBattleStarted = { battle in
                observer.onNext(BattleState(user, battle, .started))
            }
            
            return Disposables.create {}
        }
    }
}
