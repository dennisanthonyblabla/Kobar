//
//  EndBattleStateMachine.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 20/11/22.
//

import Foundation

struct EndBattleStateMachine {
    private enum State: Equatable {
        case start
        case battleDone
        case testCase
        case waitingForOpponent
        case battleResult
        case battleReview
        case finish
    }
    
    enum Event: Equatable {
        case start
        case toTestCase(SubmitCodeResult)
        case userFinished
        case bothFinished(BattleResult)
        case opponentFinished(BattleResult)
        case toReview(BattleReview)
        case backToWaiting
        case backToResult(BattleResult)
        case toFinishBattle
    }
    
    private var state: State = .start
    
    mutating func map(event: Event) -> Bool {
        switch (state, event) {
        case (.start, .start):
            state = .battleDone
            
        case (.battleDone, .toTestCase):
            state = .testCase
            
        case (.testCase, .userFinished):
            state = .waitingForOpponent
            
        case (.testCase, .bothFinished):
            state = .battleResult
            
        case (.waitingForOpponent, .opponentFinished):
            state = .battleResult
            
        case (.waitingForOpponent, .toReview):
            state = .battleReview
            
        case (.waitingForOpponent, .toFinishBattle):
            state = .finish
            
        case (.battleResult, .toReview):
            state = .battleReview
            
        case (.battleReview, .backToWaiting):
            state = .waitingForOpponent
            
        case (.battleReview, .backToResult):
            state = .battleResult
            
        case (.battleResult, .toFinishBattle):
            state = .finish
            
        default:
            print("EndBattleViewModel: Invalid event \"\(event)\" for state \"\(state)\"")
            return false
        }
        
        return true
    }
}
