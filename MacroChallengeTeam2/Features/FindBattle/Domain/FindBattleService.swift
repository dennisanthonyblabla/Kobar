//
//  FindBattleService.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 14/11/22.
//

import Foundation
import RxSwift

protocol FindBattleService {
    var battleInvitation: Single<BattleInvitation> { get }
    var battle: Observable<Battle> { get }
    func getBattleInvitation(userId: String)
    func joinBattle(userId: String, inviteCode: String)
}
