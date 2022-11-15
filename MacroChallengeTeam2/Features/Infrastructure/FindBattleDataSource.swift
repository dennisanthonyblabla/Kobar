//
//  FindBattleDataSource.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift
import RxRelay

class FindBattleDataSource: FindBattleService {
    private let socketService: SocketIODataSource
    
    init(socketService: SocketIODataSource) {
        self.socketService = socketService
    }
    
    func waitForBattle() -> Single<Battle> {
        Single<Battle>.create { [weak self] single in
            self?.socketService.onBattleFound = { battle in
                single(.success(battle))
            }
            
            return Disposables.create {}
        }
    }
    
    func createBattleInvitation(userId: String) -> Single<BattleInvitation> {
        Single<BattleInvitation>.create { [weak self] single in
            self?.socketService.onBattleInvitation = { battleInvitation in
                single(.success(battleInvitation))
            }
            
            self?.socketService.emitCreateBattleInvitationEvent(
                data: CreateBattleInvitationDto(userId: userId))
            
            return Disposables.create {}
        }
    }
    
    func joinFriend(userId: String, inviteCode: String) -> Single<Battle> {
        Single<Battle>.create { [weak self] single in
            self?.socketService.onBattleFound = { battle in
                single(.success(battle))
            }
            
            self?.socketService.emitJoinBattleEvent(
                data: JoinBattleDto(userId: userId, inviteCode: inviteCode))
            
            return Disposables.create {}
        }
    }
}
