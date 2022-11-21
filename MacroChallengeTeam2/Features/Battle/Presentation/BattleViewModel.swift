//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift
import RxRelay

final class BattleViewModel {
    enum State: Equatable {
        case battle(Battle)
        case finished(SubmitCodeResult, BattleResult?)
    }
    
    enum Event: Equatable {
        case start
        case finishBattle(SubmitCodeResult, BattleResult?)
    }
    
    enum DocumentationState: Equatable {
        case opened
        case closed
    }
    
    private let service: BattleService
    private let battle: Battle
    private let userId: String
    
    private let events = PublishRelay<Event>()
    private let documentationSubject = BehaviorRelay<DocumentationState>(value: .closed)
    private let statusMessageSubject = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    init(service: BattleService, battle: Battle, userId: String) {
        self.service = service
        self.battle = battle
        self.userId = userId
    }
    
    var opponentName: String {
        let opponent = battle.users.first { $0.id != userId }
        return opponent?.nickname ?? ""
    }
    
    var state: Observable<State> {
        events
            .startWith(.start)
            .scan(State.battle(battle)) { prevState, event in
                switch (prevState, event) {
                case let (.battle(battle), .start):
                    return .battle(battle)
                    
                case let (.battle, .finishBattle(submitCodeResult, battleResult)):
                    return .finished(submitCodeResult, battleResult)
                    
                default:
                    print("InviteFriendViewModel: Invalid event \"\(event)\" for state \"\(prevState)\"")
                    return prevState
                }
            }
            .distinctUntilChanged()
    }
    
    var documentationState: Observable<DocumentationState> {
        documentationSubject
            .asObservable()
            .distinctUntilChanged()
    }
    
    func showDocumentation() {
        documentationSubject.accept(.opened)
    }
    
    func hideDocumentation() {
        documentationSubject.accept(.closed)
    }
    
    func submitCode(submission: SubmitCodeSubmission, problemId: String) {
        service.submitCode(
            userId: userId,
            battleId: battle.id,
            problemId: problemId,
            submission: submission)
        .subscribe { [weak self] submitCodeResult, battleResult in
            self?.events.accept(
                .finishBattle(
                    submitCodeResult,
                    battleResult))
        }
        .disposed(by: disposeBag)
    }
}
