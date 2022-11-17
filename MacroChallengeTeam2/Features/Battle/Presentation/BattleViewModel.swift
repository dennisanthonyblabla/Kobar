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
        case finished(SubmitCodeResult)
    }
    
    enum Event: Equatable {
        case finishBattle(SubmitCodeResult)
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
    private let runCodeResultSubject = PublishRelay<RunCodeResult>()
    private let statusMessageSubject = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    init(service: BattleService, battle: Battle, userId: String) {
        self.service = service
        self.battle = battle
        self.userId = userId
    }
    
    var state: Observable<State> {
        Observable.merge(
            .just(.battle(battle))
        )
    }
    
    var documentationState: Observable<DocumentationState> {
        documentationSubject
            .asObservable()
            .distinctUntilChanged()
            .debug()
    }
    
    func showDocumentation() {
        documentationSubject.accept(.opened)
    }
    
    func hideDocumentation() {
        documentationSubject.accept(.closed)
    }
    
    func runCode(submission: RunCodeSubmission, problemId: String) {
        service.runCode(
            userId: userId,
            battleId: battle.id,
            problemId: problemId,
            submission: submission)
        .subscribe { [weak self] result in
            self?.runCodeResultSubject.accept(result)
        }
        .disposed(by: disposeBag)
    }
    
    func submitCode(submission: SubmitCodeSubmission, problemId: String) {
        service.submitCode(
            userId: userId,
            battleId: battle.id,
            problemId: problemId,
            submission: submission)
        .subscribe { [weak self] result in
            self?.events.accept(.finishBattle(result))
        }
        .disposed(by: disposeBag)
    }
}
