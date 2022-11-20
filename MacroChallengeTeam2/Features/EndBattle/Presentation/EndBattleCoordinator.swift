//
//  EndBattleCoordinator.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 18/11/22.
//

import UIKit
import RxSwift

final class EndBattleCoordinator: BaseCoordinator {
    private let viewModel: EndBattleViewModel
    private let disposeBag = DisposeBag()
    
    private let navigationController: UINavigationController
    private let makeBattleDone: () -> UIViewController
    private let makeTestCase: (SubmitCodeResult) -> UIViewController
    private let makeWaitingForOpponentFinish: () -> UIViewController
    private let makeBattleReview: (BattleReview) -> UIViewController
    private let makeBattleResult: (BattleResult) -> UIViewController
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: EndBattleViewModel,
        makeBattleDone: @escaping () -> UIViewController,
        makeTestCase: @escaping (SubmitCodeResult) -> UIViewController,
        makeWaitingForOpponentFinish: @escaping () -> UIViewController,
        makeBattleReview: @escaping (BattleReview) -> UIViewController,
        makeBattleResult: @escaping (BattleResult) -> UIViewController
    ) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        self.makeBattleDone = makeBattleDone
        self.makeTestCase = makeTestCase
        self.makeWaitingForOpponentFinish = makeWaitingForOpponentFinish
        self.makeBattleReview = makeBattleReview
        self.makeBattleResult = makeBattleResult
        
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.events
            .subscribe { [weak self] in self?.onStateChanged($0) }
            .disposed(by: disposeBag)
    }
    
    private func onStateChanged(_ event: EndBattleViewModel.Event) {
        switch event {
        case .start:
            show(makeBattleDone())
            
        case let .toTestCase(testCases):
            show(makeTestCase(testCases))
                 
        case .userFinished:
            show(makeWaitingForOpponentFinish())
            
        case let .opponentFinished(battleResult):
            show(makeBattleResult(battleResult))
                 
        case let .bothFinished(battleResult):
            show(makeBattleResult(battleResult))
                 
        case let .toReview(battleReview):
            push(makeBattleReview(battleReview))
                 
        case .backToWaiting:
            back()
            
        case let .backToResult(battleResult):
            back()
            show(makeBattleResult(battleResult))
                 
        case .toFinishBattle:
            pop()
            finishCoordinator()
        }
    }
    
    private func back() {
        navigationController.popViewController(animated: true)
    }
    
    private func pop() {
        navigationController.popToRootViewController(animated: true)
    }
    
    private func push(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
