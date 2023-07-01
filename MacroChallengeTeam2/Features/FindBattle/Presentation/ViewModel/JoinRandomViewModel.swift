//
//  JoinRandomViewModel.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 28/06/23.
//

import RxSwift
import RxRelay

class JoinRandomViewModel {
    enum State: Equatable {
        case loading
        case waitingForStart(Battle)
        case battleStarted(Battle)
        case canceledJoin
        case canceled(String)
    }
    
    enum Event: Equatable {
        case start
        case opponentFound(Battle)
        case startBattle(Battle)
        case cancelJoinBattle
        case cancelBattle
        case rejoinBattle(Battle)
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
                    
                case let (.loading, .rejoinBattle(battle)):
                    return .battleStarted(battle)
                    
                case (.loading, .cancelJoinBattle):
                    return .canceledJoin
                    
                case let (.waitingForStart, .startBattle(battle)):
                    return .battleStarted(battle)

                case let (.waitingForStart(battle), .cancelBattle):
                    return .canceled(battle.id)
                    
                default:
                    print("JoinFriendViewModel: Invalid event \"\(event)\" for state \"\(prevState)\"")
                    return prevState
                }
            }
            .do { [weak self] state in
                switch state {
                case .waitingForStart:
                    self?.waitForStart()
                case let .canceled(battleId):
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
                if battle.problem != nil {
                    self.events.accept(.rejoinBattle(battle))
                    return
                }
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
    
    func cancelJoinBattle() {
        events.accept(.cancelJoinBattle)
    }
    
    func cancelBattle() {
        events.accept(.cancelBattle)
    }
}
