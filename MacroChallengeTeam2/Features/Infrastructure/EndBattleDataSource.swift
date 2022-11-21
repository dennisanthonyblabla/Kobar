//
//  EndBattleDataSource.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 19/11/22.
//

import Foundation
import RxSwift

final class EndBattleDataSource: EndBattleService {
    private let socketService: SocketIODataSource
    
    init(socketService: SocketIODataSource) {
        self.socketService = socketService
    }
    
    func waitForBattleFinish() -> Single<BattleResult> {
        Single<BattleResult>.create { [weak self] single in
            self?.socketService.onBattleFinished = { battleResult in
                single(.success(battleResult))
            }
            
            return Disposables.create {
                self?.socketService.onBattleFinished = { _ in }
            }
        }
    }
}
