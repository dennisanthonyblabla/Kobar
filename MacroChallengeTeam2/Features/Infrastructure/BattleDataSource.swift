//
//  BattleDataSource.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift
import RxRelay

class BattleDataSource: BattleService {
    private let battleSubject = PublishSubject<Battle?>()
    private let socketService: SocketIODataSource
    
    var battle: Observable<Battle?> {
        battleSubject.asObservable()
    }
    
    init(socketService: SocketIODataSource) {
        self.socketService = socketService
        
        self.socketService.onBattleCanceled = { [weak self] in
            self?.battleSubject.onNext(nil)
        }
        
        self.socketService.onBattleStarted = { [weak self] battle in
            self?.battleSubject.onNext(battle)
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
    
    func runCode(userId: String, battleId: String, problemId: String, submission: RunCodeSubmission) {
        socketService.emitRunCodeEvent(
            data: RunCodeDto(
                userId: userId,
                battleId: battleId,
                problemId: problemId,
                code: submission.code,
                input: submission.input))
    }
    
    func submitCode(userId: String, battleId: String, problemId: String, submission: SubmitCodeSubmission) {
        socketService.emitSubmitCodeEvent(
            data: SubmitCodeDto(
                userId: userId,
                battleId: battleId,
                problemId: problemId,
                code: submission.code))
    }
}
