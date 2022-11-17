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
        case battle(Battle)
    }
    
    private let service: BattleService
    private let battle: Battle
    
    init(service: BattleService, battle: Battle) {
        self.service = service
        self.battle = battle
    }
    
    var state: Observable<State> {
        Observable.merge(
            .just(.battle(battle))
        )
    }
}
