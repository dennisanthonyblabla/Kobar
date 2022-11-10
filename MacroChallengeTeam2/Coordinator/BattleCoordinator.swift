//
//  BattleCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import RxSwift

final class BattleCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    
    private let battleViewModel: BattleViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
        user: User,
        battle: Battle
    ) {
        self.navigationController = navigationController
        self.battleViewModel = BattleViewModel(
            socketService: socketService,
            user: user,
            battle: battle)
    }
    
    override func start() {
        battleViewModel.battleState()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] state in
                self?.onBattleStateChanged(state)
            }
            .disposed(by: disposeBag)
    }
    
    func onBattleStateChanged(_ state: BattleViewModel.BattleState) {
        switch state.status {
        case .pending:
            let readyVC = makeReadyForBattlePageViewController(user: state.user, with: state.battle)
            show(readyVC)
        case .started:
            break
        case .canceled:
            pop()
            completion?()
        }
    }
    
    func makeReadyForBattlePageViewController(
        user: User,
        with battle: Battle
    ) -> ReadyForBattlePageViewController {
        let readyVC = ReadyForBattlePageViewController()
        
        readyVC.user = battle.users.first { user.id == $0.id } ?? .empty()
        readyVC.opponent = battle.users.first { user.id != $0.id } ?? .empty()
        
        readyVC.onBack = { [weak self] in
            self?.battleViewModel.cancel()
        }
        
        readyVC.onReady = { [weak self] in
            self?.battleViewModel.start()
        }
        
        readyVC.onCountdownFinished = { [weak self] in
            self?.battleViewModel.start()
        }
        
        readyVC.startDate = battle.startTime
        
        return readyVC
    }
    
    func makeBattlefieldPageViewController() {
        let battleVC = BattlefieldViewController()
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
