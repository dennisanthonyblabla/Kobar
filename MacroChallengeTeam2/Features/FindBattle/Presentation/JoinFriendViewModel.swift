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
        case battleFound(Battle)
    }
    
    private let service: FindBattleService
    private let userId: String
    private var inviteCode: String = ""
    
    init(service: FindBattleService, userId: String) {
        self.service = service
        self.userId = userId
    }
    
    func setInviteCode(inviteCode: String) {
        self.inviteCode = inviteCode
    }
    
    func joinFriend() -> Observable<State> {
        return Observable.merge(
            .just(.loading),
            service
                .joinFriend(userId: userId, inviteCode: inviteCode)
                .asObservable()
                .map { .battleFound($0) }
        )
    }
}
