//
//  EndBattleService.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 20/11/22.
//

import Foundation
import RxSwift

protocol EndBattleService {
    func waitForBattleFinish() -> Single<BattleResult>
}
