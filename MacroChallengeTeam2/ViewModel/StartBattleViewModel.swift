//
//  StartBattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift

struct StartBattleState {
    let user: User
    let battle: Battle
    let status: StartBattleStatus
    
    init(_ user: User, _ battle: Battle, _ status: StartBattleStatus) {
        self.user = user
        self.battle = battle
        self.status = status
    }
}

enum StartBattleStatus {
    case pending
    case started
    case canceled
}

class StartBattleViewModel {
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
    
    func battleState() -> Observable<StartBattleState> {
        Observable<StartBattleState>.create { [weak self, user, battle] observer in
            // If battle problem is nil, then battle hasn't started
            // Otherwise, battle must have started already
            let initialStatus: StartBattleStatus = battle.problem == nil ? .pending : .started
            
            observer.onNext(StartBattleState(user, battle, initialStatus))
            
            self?.socketService.onBattleCanceled = {
                observer.onNext(StartBattleState(user, battle, .canceled))
                observer.onCompleted()
            }
            
            self?.socketService.onBattleStarted = { noUserBattle in
                guard let battle = self?.battle else { return }
                observer.onNext(StartBattleState(user, noUserBattle.join(with: battle), .started))
                observer.onCompleted()
            }
            
            return Disposables.create {}
        }
    }
}
