//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift

struct BattleViewModel {
    enum State: Equatable {
        case loading
        case canceled
        case countdown(Battle)
        case battle(Battle)
        case finished
    }
    
    private let service: BattleService
    
    init(service: BattleService) {
        self.service = service
    }
    
    var state: Observable<State> {
        Observable.merge(
            mapBattleToState(),
            .just(.loading)
        )
    }
    
    private func mapBattleToState() -> Observable<State> {
        service.battle
            .map { battle in
                guard let battle = battle else { return .canceled }
                guard battle.problem != nil else { return .countdown(battle) }
                return .battle(battle)
            }
    }
}
