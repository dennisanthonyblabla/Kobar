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
    
    func waitForOpponent() -> Single<Battle> {
        Single<Battle>.create { [weak self] single in
            self?.socketService.onOpponentFound = { battle in
                single(.success(battle))
            }
            
            return Disposables.create {
                self?.socketService.onOpponentFound = { _ in }
            }
        }
    }
    
    func waitForStart() -> Single<Battle?> {
        Single<Battle?>.create { [weak self] single in
            self?.socketService.onBattleCanceled = {
                single(.success(nil))
            }
            
            self?.socketService.onBattleStarted = { battle in
                single(.success(battle))
            }
            
            return Disposables.create {
                self?.socketService.onBattleCanceled = {}
                self?.socketService.onBattleStarted = { _ in }
            }
        }
    }
    
    func cancelBattle(battleId: String) {
        socketService.emitCancelBattleEvent(
            data: CancelBattleDto(battleId: battleId))
    }
    
    func createBattleInvitation(userId: String) -> Single<BattleInvitation> {
        Single<BattleInvitation>.create { [weak self] single in
            self?.socketService.onBattleInvitation = { battleInvitation in
                single(.success(battleInvitation))
            }
            
            self?.socketService.emitCreateBattleInvitationEvent(
                data: CreateBattleInvitationDto(userId: userId))
            
            return Disposables.create {
                self?.socketService.onBattleInvitation = { _ in }
            }
        }
    }
    
    func joinFriend(userId: String, inviteCode: String) -> Single<Battle> {
        Single<Battle>.create { [weak self] single in
            self?.socketService.onOpponentFound = { battle in
                single(.success(battle))
            }
            
            self?.socketService.onBattleRejoined = { battle in
                single(.success(battle))
            }
            
            self?.socketService.emitJoinBattleEvent(
                data: JoinBattleDto(userId: userId, inviteCode: inviteCode))
            
            return Disposables.create {
                self?.socketService.onOpponentFound = { _ in }
                self?.socketService.onBattleRejoined = { _ in }
            }
        }
    }
}
