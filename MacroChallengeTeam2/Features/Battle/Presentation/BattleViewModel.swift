//
//  BattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift
import RxRelay

struct BattleViewModel {
    enum State: Equatable {
        case battle(Battle)
        case finished
    }
    
    enum DocumentationState: Equatable {
        case opened
        case closed
    }
    
    enum RunCodeState: Equatable {
        case loading
        case finished(String)
    }
    
    private let service: BattleService
    private let battle: Battle
    
    private let documentationSubject = BehaviorRelay<DocumentationState>(value: .closed)
    
    init(service: BattleService, battle: Battle) {
        self.service = service
        self.battle = battle
    }
    
    var state: Observable<State> {
        Observable.merge(
            .just(.battle(battle))
        )
    }
    
    var documentationState: Observable<DocumentationState> {
        documentationSubject
            .asObservable()
            .debug()
    }
    
    func showDocumentation() {
        documentationSubject.accept(.opened)
    }
    
    func hideDocumentation() {
        documentationSubject.accept(.closed)
    }
    
    func runCode() {
        
    }
    
    func submitCode() {
        
    }
}
