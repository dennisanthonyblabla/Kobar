//
//  JoinFriendViewModel.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift
import RxRelay

class JoinFriendViewModel {
    enum State: Equatable {
        case loading
        case waitingForStart(Battle)
        case battleStarted(Battle)
        case canceled(String?)
    }
    
    enum Event: Equatable {
        case start
        case opponentFound(Battle)
        case startBattle(Battle)
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
                
                case let (.loading, .opponentFound(battle)):
                    return .waitingForStart(battle)
                    
                case (.loading, .cancelBattle):
                    return .canceled(nil)
                    
                case let (.waitingForStart, .startBattle(battle)):
                    return .battleStarted(battle)

                case let (.waitingForStart(battle), .cancelBattle):
                    return .canceled(battle.id)
                    
                default:
                    print("InviteFriendViewModel: Invalid event \"\(event)\" for state \"\(prevState)\"")
                    return prevState
                }
            }
            .do { [weak self] state in
                switch state {
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
    
    func joinFriend(inviteCode: String) {
        service.joinFriend(userId: userId, inviteCode: inviteCode)
            .asObservable()
            .subscribe { battle in
                self.events.accept(.opponentFound(battle))
            }
            .disposed(by: disposeBag)
    }
    
    func waitForStart() {
        service.waitForStart()
            .asObservable()
            .subscribe { [unowned self] battle in
                guard let battle = battle else {
                    self.events.accept(.cancelBattle)
                    return
                }
                self.events.accept(.startBattle(battle))
            }
            .disposed(by: disposeBag)
    }
    
    func cancelBattle() {
        events.accept(.cancelBattle)
    }
}
