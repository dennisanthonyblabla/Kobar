//
//  FindBattleService.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 14/11/22.
//

import Foundation
import RxSwift

protocol FindBattleService {
    func waitForOpponent() -> Single<Battle>
    func waitForStart() -> Single<Battle?>
    func cancelBattle(battleId: String)
    func createBattleInvitation(userId: String) -> Single<BattleInvitation>
    func joinFriend(userId: String, inviteCode: String) -> Single<Battle>
}
