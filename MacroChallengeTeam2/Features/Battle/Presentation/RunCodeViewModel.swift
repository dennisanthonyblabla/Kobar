//
//  RunCodeViewModel.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 20/11/22.
//

import Foundation
import RxSwift
import RxRelay

final class RunCodeViewModel {
    private let service: BattleService
    private let userId: String
    private let battleId: String
    
    private let runCodeSubject = PublishRelay<(RunCodeSubmission, String)>()
    
    init(service: BattleService, userId: String, battleId: String) {
        self.service = service
        self.userId = userId
        self.battleId = battleId
    }
    
    var runCodeResult: Observable<RunCodeResult> {
        runCodeSubject
            .flatMap { [service, userId, battleId] runCodeSubmission, problemId in
                service
                    .runCode(
                        userId: userId,
                        battleId: battleId,
                        problemId: problemId,
                        submission: runCodeSubmission)
                    .asObservable()
            }
    }
    
    func runCode(submission: RunCodeSubmission, problemId: String) {
        runCodeSubject.accept((submission, problemId))
    }
}
