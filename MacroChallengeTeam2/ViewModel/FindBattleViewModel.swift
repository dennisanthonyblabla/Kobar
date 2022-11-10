//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

class FindBattleViewModel {
    private let socketService: SocketIODataSource
    private let user: User
    
    init(socketService: SocketIODataSource, user: User) {
        self.socketService = socketService
        self.user = user
    }
    
    func createBattle() -> Single<(User, BattleInvitation)> {
        Single<(User, BattleInvitation)>.create { [weak self, user] single in
            self?.socketService.onBattleInvitation = { battleInvitation in
                single(.success((user, battleInvitation)))
            }
            
            self?.socketService.emitCreateBattleInvitationEvent(
                data: CreateBattleInvitationDto(userId: user.id))
            
            return Disposables.create {}
        }
    }
    
    func joinBattle(inviteCode: String) {
        socketService.emitJoinBattleEvent(
            data: JoinBattleDto(userId: user.id, inviteCode: inviteCode))
    }
    
    func playersFoundState() -> Single<(User, Battle)> {
        Single<(User, Battle)>.create { [weak self, user] single in
            self?.socketService.onBattleFound = { battle in
                single(.success((user, battle)))
            }
            
            self?.socketService.onBattleRejoined = { battle in
                single(.success((user, battle)))
            }
            
            return Disposables.create {}
        }
    }
}
