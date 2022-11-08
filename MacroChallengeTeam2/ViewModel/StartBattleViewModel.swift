//
//  StartBattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

final class StartBattleViewModel {
    enum StartBattleEvent {
        case inviteFriend, joinFriend, joinRandom
    }
    
    let battleEventSubject = PublishSubject<StartBattleEvent>()
    
    func inviteFriend() {
        battleEventSubject.onNext(.inviteFriend)
    }
    
    func joinFriend() {
        battleEventSubject.onNext(.joinFriend)
    }
    
    func joinRandom() {
        battleEventSubject.onNext(.joinRandom)
    }
}
