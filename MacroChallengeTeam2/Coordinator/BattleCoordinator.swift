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
    
    private let startBattleViewModel: StartBattleViewModel
    private let battleViewModel: BattleViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
        user: User,
        battle: Battle
    ) {
        self.navigationController = navigationController
        self.startBattleViewModel = StartBattleViewModel(
            socketService: socketService,
            user: user,
            battle: battle)
        self.battleViewModel = BattleViewModel(
            socketService: socketService,
            user: user,
            battle: battle)
    }
    
    override func start() {
        startBattleViewModel.battleState()
            .distinctUntilChanged { $0.status == $1.status }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] state in
                self?.onBattleStateChanged(state)
            }
            .disposed(by: disposeBag)
        
        battleViewModel.battleEndedState()
            .subscribe { [weak self] state in
                self?.onBattleFinished(state)
            }
            .disposed(by: disposeBag)
    }
    
    func onBattleStateChanged(_ state: BattleState) {
        switch state.status {
        case .pending:
            let readyVC = makeReadyForBattlePageViewController(user: state.user, with: state.battle)
            show(readyVC)
        case .started:
            let battleVC = makeBattlefieldPageViewController(state)
            show(battleVC)
        case .canceled:
            pop()
            completion?()
        }
    }
    
    func onBattleFinished(_ state: FinishedBattleState) {
        switch state {
        case .ongoing:
            break
        case .waitingForOpponent(_):
            let doneVC = makeBattleDoneViewController()
            show(doneVC)
        case .battleFinished(_):
            break
        }
    }
    
    func makeReadyForBattlePageViewController(
        user: User,
        with battle: Battle
    ) -> ReadyForBattlePageViewController {
        let readyVC = ReadyForBattlePageViewController()
        
        readyVC.user = user
        readyVC.opponent = battle.users.first { user.id != $0.id } ?? .empty()
        
        readyVC.onBack = { [weak self] in
            self?.startBattleViewModel.cancel()
            self?.pop()
        }
        
        readyVC.onReady = { [weak self] in
            self?.startBattleViewModel.start()
        }
        
        readyVC.onCountdownFinished = { [weak self] in
            self?.startBattleViewModel.start()
        }
        
        readyVC.battleStartDate = battle.startTime
        
        return readyVC
    }
    
    func makeBattlefieldPageViewController(_ state: BattleState) -> BattlefieldPageViewController {
        let battleVC = BattlefieldPageViewController()
        
        battleVC.userName = state.user.nickname
        battleVC.opponentName =
            state.battle.users.first { state.user.id != $0.id }?.nickname ?? ""
        
        battleVC.battleEndDate = state.battle.endTime
        
        if let problem = state.battle.problem {
            battleVC.problem = problem

            battleVC.onRunCode = { [weak self] submission in
                self?.battleViewModel.runCode(problemId: problem.id, submission: submission)
            }
            
            battleVC.onSubmitCode = { [weak self] submission in
                self?.battleViewModel.submitCode(problemId: problem.id, submission: submission)
            }
        }
        
        battleViewModel.runCodeState()
            .distinctUntilChanged { $0.output }
            .observe(on: MainScheduler.instance)
            .subscribe { runCodeResult in
                battleVC.updateRunCodeResult(result: runCodeResult)
            }
            .disposed(by: disposeBag)
        
        return battleVC
    }
    
    func makeBattleDoneViewController() -> BattleDoneVC {
        let doneVC = BattleDoneVC()
        
        return doneVC
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
