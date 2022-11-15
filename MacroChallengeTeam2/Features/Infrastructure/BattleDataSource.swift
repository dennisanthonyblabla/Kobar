//
//  BattleDataSource.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift

// TODO: @salman ini harusnya gapake pre start battle
class BattleDataSource: BattleService {
    private let battleSubject = PublishSubject<Battle?>()
    private let socketService: SocketIODataSource
    
    var battle: Observable<Battle?> {
        battleSubject.asObservable()
    }
    
    init(
        socketService: SocketIODataSource,
        preStartBattle: Battle
    ) {
        self.socketService = socketService
        
        self.socketService.onBattleCanceled = { [weak self] in
            self?.battleSubject.onNext(nil)
        }
        
        self.socketService.onBattleStarted = { [weak self, preStartBattle] battle in
            self?.battleSubject.onNext(battle.join(with: preStartBattle))
        }
        
        self.socketService.onBattleRejoined = { [weak self] battle in
            self?.battleSubject.onNext(battle)
        }
    }
    
    func startBattle(userId: String, battleId: String) {
        socketService.emitReadyBattleEvent(
            data: ReadyBattleDto(userId: userId, battleId: battleId))
    }
    
    func cancelBattle(battleId: String) {
        socketService.emitCancelBattleEvent(
            data: CancelBattleDto(battleId: battleId))
    }
}
