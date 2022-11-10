//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

class StartBattleViewModel {
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
        socketService.emitJoinbattleEvent(
            data: JoinBattleDto(userId: user.id, inviteCode: inviteCode))
    }
    
    func playersFoundState() -> Single<Battle> {
        Single<Battle>.create { [weak self] single in
            self?.socketService.onPlayersFound = { battle in
                single(.success(battle))
            }
            
            return Disposables.create {}
        }
    }
}