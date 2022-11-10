//
//  StartBattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift

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

class BattleViewModel {
    private let socketService: SocketIODataSource
    private let user: User
    private let battle: Battle
    
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
            // If battle problem is nil, then battle hasn't started
            // Otherwise, battle must have started already
            let initialStatus: BattleStatus = battle.problem == nil ? .pending : .started
            
            observer.onNext(BattleState(user, battle, initialStatus))
            
            self?.socketService.onBattleCanceled = {
                observer.onNext(BattleState(user, battle, .canceled))
            }
            
            self?.socketService.onBattleStarted = { noUserBattle in
                guard let battle = self?.battle else { return }
                observer.onNext(BattleState(user, noUserBattle.join(with: battle), .started))
            }
            
            return Disposables.create {}
        }
    }
}
