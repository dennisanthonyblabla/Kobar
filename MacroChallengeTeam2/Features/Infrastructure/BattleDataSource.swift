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
    }
    
    func startBattle(userId: String, battleId: String) {
        socketService.emitReadyBattleEvent(
            data: ReadyBattleDto(userId: userId, battleId: battleId))
    }
    
    func runCode(
        userId: String,
        battleId: String,
        problemId: String,
        submission: RunCodeSubmission
    ) -> Single<RunCodeResult> {
        Single<RunCodeResult>.create { [weak self] single in
            self?.socketService.onCodeRan = { result in
                single(.success(result))
            }
            
            self?.socketService.emitRunCodeEvent(
                data: RunCodeDto(
                    userId: userId,
                    battleId: battleId,
                    problemId: problemId,
                    code: submission.code,
                    input: submission.input))
            
            return Disposables.create {
                self?.socketService.onCodeRan = { _ in }
            }
        }
    }
    
    func submitCode(
        userId: String,
        battleId: String,
        problemId: String,
        submission: SubmitCodeSubmission
    ) -> Single<SubmitCodeResult> {
        Single<SubmitCodeResult>.create { [weak self] single in
            self?.socketService.onCodeSubmit = { result in
                single(.success(result))
            }
            
            self?.socketService.emitSubmitCodeEvent(
                data: SubmitCodeDto(
                    userId: userId,
                    battleId: battleId,
                    problemId: problemId,
                    code: submission.code))
            
            return Disposables.create {
                self?.socketService.onCodeSubmit = { _ in }
            }
        }
    }
}
