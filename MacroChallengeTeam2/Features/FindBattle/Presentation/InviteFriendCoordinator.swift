//
//  InviteFriendCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import UIKit
import RxSwift

// TODO: tanya design ini kira2 problem atau ngga
final class InviteFriendCoordinator: BaseCoordinator {
    private let viewModel: InviteFriendViewModel
    private let disposeBag = DisposeBag()
    
    private let navigationController: UINavigationController
    private let makeBattleInvitation: (BattleInvitation) -> UIViewController
    private let makeReadyForBattle: (Battle) -> UIViewController
    private let makeBattle: (Battle) -> Coordinator
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: InviteFriendViewModel,
        makeBattleInvitation: @escaping (BattleInvitation) -> UIViewController,
        makeReadyForBattle: @escaping (Battle) -> UIViewController,
        makeBattle: @escaping (Battle) -> Coordinator
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.makeBattleInvitation = makeBattleInvitation
        self.makeReadyForBattle = makeReadyForBattle
        self.makeBattle = makeBattle
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.state
            .subscribe { [weak self] state in self?.onStateChanged(state) }
            .disposed(by: disposeBag)
    }
    
    private func onStateChanged(_ state: InviteFriendViewModel.State) {
        switch state {
        case .loading:
            break
        case let .waitingForOpponent(battleInvitation):
            show(makeBattleInvitation(battleInvitation))
        case let .waitingForStart(battle):
            show(makeReadyForBattle(battle))
        case let .battleStarted(battle):
            startAndReplaceNextCoordinator(makeBattle(battle))
        case .canceled:
            pop()
            finishCoordinator()
        }
    }

    private func pop() {
        navigationController.popToRootViewController(animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
