//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

class CreateBattleViewModel {
    let battleInvitationSubject = BehaviorSubject<(User, BattleInvitation)?>(value: nil)
    
    private let socketService: SocketIODataSource
    private let user: User

    init(socketService: SocketIODataSource, user: User) {
        self.socketService = socketService
        self.user = user
    }
    
    func createBattle() {
        socketService.onBattleInvitation = { [weak self] battleInvitation in
            guard let self = self else { return }
            self.battleInvitationSubject.onNext((self.user, battleInvitation))
        }
        
        socketService.emitCreateBattleInvitationEvent(
            data: CreateBattleInvitationDto(userId: user.id))
    }
}
