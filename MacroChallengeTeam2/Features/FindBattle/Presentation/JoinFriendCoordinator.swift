//
//  JoinFriendCoordinator.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import Foundation
import UIKit
import RxSwift

final class JoinFriendCoordinator: BaseCoordinator {
    private let viewModel: JoinFriendViewModel
    private let disposeBag = DisposeBag()
    
    private let navigationController: UINavigationController
    private let makeJoinFriend: () -> UIViewController
    private let makeReadyForBattle: (Battle) -> UIViewController
    private let makeBattle: (Battle) -> Coordinator
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: JoinFriendViewModel,
        makeJoinFriend: @escaping () -> UIViewController,
        makeReadyForBattle: @escaping (Battle) -> UIViewController,
        makeBattle: @escaping (Battle) -> Coordinator
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.makeJoinFriend = makeJoinFriend
        self.makeReadyForBattle = makeReadyForBattle
        self.makeBattle = makeBattle
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.state
            .subscribe { [weak self] state in self?.onStateChanged(state) }
            .disposed(by: disposeBag)
    }
    
    private func onStateChanged(_ state: JoinFriendViewModel.State) {
        switch state {
        case .loading:
            present(makeJoinFriend())
        case .canceled:
            dismiss()
            pop()
        case let .waitingForStart(battle):
            dismiss()
            show(makeReadyForBattle(battle))
        case let .battleStarted(battle):
            startAndReplaceNextCoordinator(makeBattle(battle))
        }
    }
    
    private func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
        finishCoordinator()
    }
    
    private func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }

    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
