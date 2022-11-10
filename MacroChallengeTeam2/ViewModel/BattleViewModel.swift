//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift

enum FinishedBattleState {
    case ongoing
    case waitingForOpponent(SubmitCodeResult)
    case battleFinished(BattleResult)
}

final class BattleViewModel {
    private let socketService: SocketIODataSource
    private let user: User
    private let battle: Battle
    
    private let runCodeResultSubject = BehaviorSubject<RunCodeResult?>(value: nil)
    private let finishedBattleSubject = BehaviorSubject<FinishedBattleState>(value: .ongoing)
    
    init(socketService: SocketIODataSource, user: User, battle: Battle) {
        self.socketService = socketService
        self.battle = battle
        self.user = user
        
        self.socketService.onCodeRan = { [weak self] result in
            self?.runCodeResultSubject.onNext(result)
        }
        
        self.socketService.onCodeSubmit = { [weak self] result in
            self?.finishedBattleSubject.onNext(.waitingForOpponent(result))
        }
    }
    
    func runCode(problemId: String, submission: RunCodeSubmission) {
        socketService.emitRunCodeEvent(
            data: RunCodeDto(
                userId: user.id,
                battleId: battle.id,
                problemId: problemId,
                code: submission.code,
                input: submission.input))
    }
    
    func submitCode(problemId: String, submission: SubmitCodeSubmission) {
        socketService.emitSubmitCodeEvent(
            data: SubmitCodeDto(
                userId: user.id,
                battleId: battle.id,
                problemId: problemId,
                code: submission.code))
    }
    
    func runCodeState() -> Observable<RunCodeResult> {
        runCodeResultSubject
            .compactMap { $0 }
            .asObservable()
    }
    
    func battleEndedState() -> Observable<FinishedBattleState> {
        finishedBattleSubject
            .asObservable()
    }
}
