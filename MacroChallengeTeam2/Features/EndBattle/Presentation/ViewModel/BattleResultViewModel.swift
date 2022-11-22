//
//  BattleResultViewModel.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 20/11/22.
//

import Foundation

final class BattleResultViewModel {
    enum Winner {
        case user, opponent, draw
    }
    
    private let battle: Battle
    private let result: BattleResult
    private let winner: Winner
    
    let user: User
    let opponent: User
    let userEvaluationViewModel: BattleEvaluationViewModel
    let opponentEvaluationViewModel: BattleEvaluationViewModel
    
    init(battle: Battle, result: BattleResult, user: User) {
        self.battle = battle
        self.result = result
        
        winner = result.isDraw
        ? .draw
        : result.winnerId == user.id ? .user : .opponent
        
        let opponent = battle.users.first { $0.id != user.id } ?? .empty()
        
        let userEvaluation = result.evaluations.first { $0.userId == user.id } ?? .empty()
        let opponentEvaluation = result.evaluations.first { $0.userId == opponent.id } ?? .empty()
        
        let testCaseCount = battle.problem?.testCases.count ?? 0
        
        userEvaluationViewModel = BattleEvaluationViewModel(
            userEvaluation,
            testCaseCount: testCaseCount)
        opponentEvaluationViewModel = BattleEvaluationViewModel(
            opponentEvaluation,
            testCaseCount: testCaseCount)
        
        self.user = user
        self.opponent = opponent
    }
    
    var score: Int {
        result.score
    }
    
    var userScoreState: String {
        winner == .draw
        ? ""
        : winner == .user ? "+" : "-"
    }
    
    var opponentScoreState: String {
        winner == .draw
        ? ""
        : winner == .opponent ? "+" : "-"
    }
    
    var isUserWin: Bool {
        winner == .user
    }
    
    var isOpponentWin: Bool {
        winner == .user
    }
    
    var descState: String {
        winner == .draw
        ? "Wah, seri nih coy!\nPertandingan selanjutnya lo pasti bisa menang!"
        : winner == .user
        ? "Keren lo menang Coy!\nMantep banget!"
        : "Kalah itu biasa! Yang penting ada hal\nbaru yang didapet. Semangat!!"
    }
}
