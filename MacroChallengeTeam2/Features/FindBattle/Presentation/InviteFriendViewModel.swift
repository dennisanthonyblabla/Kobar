//
//  InviteFriendViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

class InviteFriendViewModel {
    enum State: Equatable {
        case loading
        case battleInvitationCreated(BattleInvitation)
        case battleFound(Battle)
    }
    
    private let service: FindBattleService
    
    init(service: FindBattleService) {
        self.service = service
    }
    
    var state: Observable<State> {
        Observable.merge(
            mapBattleToState(),
            mapBattleInvitationToState(),
            .just(.loading)
        )
    }
    
    private func mapBattleInvitationToState() -> Observable<State> {
        service.battleInvitation
            .map { .battleInvitationCreated($0) }
            .asObservable()
    }
    
    private func mapBattleToState() -> Observable<State> {
        service.battle
            .map { .battleFound($0) }
    }
}
