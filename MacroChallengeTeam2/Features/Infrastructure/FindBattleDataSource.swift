//
//  FindBattleDataSource.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift

class FindBattleDataSource: FindBattleService {
    private let battleInvitationSubject = PublishSubject<BattleInvitation>()
    private let battleSubject = PublishSubject<Battle>()
    private let socketService: SocketIODataSource
    
    var battleInvitation: Single<BattleInvitation> {
        battleInvitationSubject.asSingle()
    }
    
    var battle: Observable<Battle> {
        battleSubject.asObservable()
    }
    
    init(socketService: SocketIODataSource) {
        self.socketService = socketService
        
        self.socketService.onBattleFound = { [weak self] battle in
            self?.battleSubject.onNext(battle)
        }
        
        self.socketService.onBattleInvitation = { [weak self] battleInvitation in
            self?.battleInvitationSubject.onNext(battleInvitation)
        }
    }
    
    func getBattleInvitation(userId: String) {
        socketService.emitCreateBattleInvitationEvent(
            data: CreateBattleInvitationDto(userId: userId))
    }
    
    func joinBattle(userId: String, inviteCode: String) {
        socketService.emitJoinBattleEvent(
            data: JoinBattleDto(userId: userId, inviteCode: inviteCode))
    }
}
