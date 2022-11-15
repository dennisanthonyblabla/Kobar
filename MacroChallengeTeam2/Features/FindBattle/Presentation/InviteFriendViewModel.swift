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
    private let userId: String
    
    init(service: FindBattleService, userId: String) {
        self.service = service
        self.userId = userId
    }
    
    func inviteFriend() -> Observable<State> {
        Observable.merge(
            .just(.loading),
            service
                .createBattleInvitation(userId: userId)
                .asObservable()
                .map { State.battleInvitationCreated($0) },
            service
                .waitForBattle()
                .asObservable()
                .map { State.battleFound($0) }
        )
    }
}
