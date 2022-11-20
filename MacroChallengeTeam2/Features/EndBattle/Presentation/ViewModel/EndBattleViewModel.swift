//
//  EndBattleViewModel.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 18/11/22.
//

import Foundation
import RxSwift
import RxRelay

final class EndBattleViewModel {
    typealias Event = EndBattleStateMachine.Event
    
    private let service: EndBattleService
    
    private let eventsSubject = PublishRelay<Event>()
    private var stateMachine = EndBattleStateMachine()
    private let disposeBag = DisposeBag()
    
    private let submitCodeResult: SubmitCodeResult
    private let battleReview: BattleReview
    private var battleResult: BattleResult?
    
    init(service: EndBattleService, submitCodeResult: SubmitCodeResult, battleResult: BattleResult?) {
        self.service = service
        self.submitCodeResult = submitCodeResult
        self.battleReview = BattleReview(
            reviewVideoURL: submitCodeResult.problem.reviewVideoURL,
            reviewText: submitCodeResult.problem.reviewText)
        self.battleResult = battleResult
        
        service.waitForBattleFinish()
            .subscribe { [weak self] battleResult in
                guard let self = self else { return }
                self.battleResult = battleResult
                self.eventsSubject.accept(.opponentFinished(battleResult))
            }
            .disposed(by: disposeBag)
    }
    
    var events: Observable<Event> {
        eventsSubject
            .startWith(.start)
            .map { [weak self] event in
                guard let self = self else { return .none }
                let isValidTransition = self.stateMachine.map(event: event)
                return isValidTransition ? .some(event) : .none
            }
            .compactMap { $0 }
            .distinctUntilChanged()
    }
    
    func toTestCase() {
        eventsSubject.accept(.toTestCase(submitCodeResult))
    }
    
    func toWaiting() {
        guard let battleResult = battleResult else {
            eventsSubject.accept(.userFinished)
            return
        }
        
        eventsSubject.accept(.bothFinished(battleResult))
    }
    
    func toReview() {
        eventsSubject.accept(.toReview(battleReview))
    }
    
    func backFromReview() {
        guard let battleResult = battleResult else {
            eventsSubject.accept(.backToWaiting)
            return
        }
        
        eventsSubject.accept(.backToResult(battleResult))
    }
    
    func toFinishBattle() {
        eventsSubject.accept(.toFinishBattle)
    }
}
