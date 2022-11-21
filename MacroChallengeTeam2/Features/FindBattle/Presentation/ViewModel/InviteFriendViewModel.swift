//
//  InviteFriendViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift
import RxRelay

class InviteFriendViewModel {
    enum State: Equatable {
        case loading
        case waitingForOpponent(BattleInvitation)
        case waitingForStart(Battle)
        case battleStarted(Battle)
        case canceled(String?)
    }
    
    enum Event: Equatable {
        case start
        case battleInvitationCreated(BattleInvitation)
        case opponentLeft
        case opponentFound(Battle)
        case startBattle(Battle)
        case cancelBattleInvitation
        case cancelBattle
    }
    
    private let service: FindBattleService
    private let userId: String
    
    private let events = PublishRelay<Event>()
    private let disposeBag = DisposeBag()
    
    init(service: FindBattleService, userId: String) {
        self.service = service
        self.userId = userId
    }
    
    var state: Observable<State> {
        events
            .startWith(.start)
            .scan(State.loading) { prevState, event in
                switch (prevState, event) {
                case (.loading, .start):
                    return .loading
                    
                case let (.loading, .battleInvitationCreated(battleInvitation)):
                    return .waitingForOpponent(battleInvitation)
                    
                case let (.waitingForOpponent, .opponentFound(battle)):
                    return .waitingForStart(battle)
                    
                case (.waitingForOpponent, .cancelBattleInvitation):
                    return .canceled(nil)
                    
                case let (.waitingForStart, .startBattle(battle)):
                    return .battleStarted(battle)
                
                case (.waitingForStart, .opponentLeft):
                    return .loading
                    
                case let (.waitingForStart(battle), .cancelBattle):
                    return .canceled(battle.id)
                    
                default:
                    print("InviteFriendViewModel: Invalid event \"\(event)\" for state \"\(prevState)\"")
                    return prevState
                }
            }
            // Side effects (network calls)
            .do { [weak self] state in
                switch state {
                case .loading:
                    self?.createBattleInvitation()
                case .waitingForOpponent:
                    self?.waitForOpponent()
                case .waitingForStart:
                    self?.waitForStart()
                case let .canceled(battleId):
                    guard let battleId = battleId else { break }
                    self?.service.cancelBattle(battleId: battleId)
                default:
                    break
                }
            }
            .distinctUntilChanged()
    }
    
    func createBattleInvitation() {
        service.createBattleInvitation(userId: userId)
            .asObservable()
            .subscribe { [unowned self] in
                self.events.accept(.battleInvitationCreated($0))
            }
            .disposed(by: disposeBag)
    }
    
    func waitForOpponent() {
        service.waitForOpponent()
            .asObservable()
            .subscribe { [unowned self] in
                self.events.accept(.opponentFound($0))
            }
            .disposed(by: disposeBag)
    }
    
    func waitForStart() {
        service.waitForStart()
            .asObservable()
            .subscribe { [unowned self] battle in
                guard let battle = battle else {
                    self.events.accept(.opponentLeft)
                    return
                }
                
                self.events.accept(.startBattle(battle))
            }
            .disposed(by: disposeBag)
    }
    
    func cancelBattle() {
        events.accept(.cancelBattle)
    }
    
    func cancelBattleInvitation() {
        events.accept(.cancelBattleInvitation)
    }
}
