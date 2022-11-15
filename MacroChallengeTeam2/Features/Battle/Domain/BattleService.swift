//
//  BattleService.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import RxSwift

protocol BattleService {
    var battle: Observable<Battle?> { get }
    func startBattle(userId: String, battleId: String)
    func cancelBattle(battleId: String)
    func runCode(userId: String, battleId: String, problemId: String, submission: RunCodeSubmission)
    func submitCode(userId: String, battleId: String, problemId: String, submission: SubmitCodeSubmission)
}
