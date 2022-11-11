//
//  BattleViewModel.swift
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
    case ongoing
    case waitingForOpponent(SubmitCodeResult)
    case battleFinished(BattleResult)
}

final class BattleViewModel {
    private let socketService: SocketIODataSource
    private let user: User
    private let battle: Battle
    
    // TODO: @salman exposing state
    var problem: Problem {
        battle.problem ?? .empty()
    }
    var code: String = ""
    
    private let runCodeResultSubject = BehaviorSubject<RunCodeResult?>(value: nil)
    private let finishedBattleSubject = BehaviorSubject<BattleState?>(value: nil)
    
    init(socketService: SocketIODataSource, user: User, battle: Battle) {
        self.socketService = socketService
        self.battle = battle
        self.user = user
        
        self.socketService.onCodeRan = { [weak self] result in
            self?.runCodeResultSubject.onNext(result)
        }
        
        self.socketService.onCodeSubmit = { [weak self, user, battle] result in
            self?.code = result.code
            self?.finishedBattleSubject.onNext(
                BattleState(user, battle, .waitingForOpponent(result)))
        }
        
        self.socketService.onBattleFinished = { [weak self, user, battle] result in
            self?.finishedBattleSubject.onNext(
                BattleState(user, battle, BattleStatus.battleFinished(result)))
            self?.finishedBattleSubject.onCompleted()
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
    
    func battleStatus() -> Observable<BattleState> {
        finishedBattleSubject
            .compactMap { $0 }
            .asObservable()
    }
}
