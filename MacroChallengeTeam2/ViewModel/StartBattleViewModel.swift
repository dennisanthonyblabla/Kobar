//
//  StartBattleViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import RxSwift

class StartBattleViewModel {
    private let socketService: SocketIODataSource
    private let battle: Battle
    
    init(socketService: SocketIODataSource, battle: Battle) {
        self.socketService = socketService
        self.battle = battle
    }
    
    func ready() {
        
    }
    
    func cancel() {
        
    }
    
    func startBattleState() {
        
    }
}
