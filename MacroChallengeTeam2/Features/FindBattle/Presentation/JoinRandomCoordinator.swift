//
//  JoinRandomCoordinator.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 28/06/23.
//

import Foundation
import UIKit
import RxSwift

final class JoinRandomCoordinator: BaseCoordinator {
    private let viewModel: JoinRandomViewModel
    private let disposeBag = DisposeBag()
    
    private let navigationController: UINavigationController
    private let makeJoinRandom: () -> UIViewController
    private let makeReadyForBattle: (Battle) -> UIViewController
    private let makeBattle: (Battle) -> Coordinator
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: JoinRandomViewModel,
        makeJoinRandom: @escaping () -> UIViewController,
        makeReadyForBattle: @escaping (Battle) -> UIViewController,
        makeBattle: @escaping (Battle) -> Coordinator
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.makeJoinRandom = makeJoinRandom
        self.makeReadyForBattle = makeReadyForBattle
        self.makeBattle = makeBattle
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.state
            .subscribe { [weak self] state in self?.onStateChanged(state) }
            .disposed(by: disposeBag)
    }

    private func onStateChanged(_ state: JoinRandomViewModel.State) {
        switch state {
        case .loading:
            present(makeJoinRandom())
        case .canceledJoin:
            dismiss()
            finishCoordinator()
        case .canceled:
            pop()
            finishCoordinator()
        case let .waitingForStart(battle):
            dismiss()
            show(makeReadyForBattle(battle))
        case let .battleStarted(battle):
            dismiss()
            startAndReplaceNextCoordinator(makeBattle(battle))
        }
    }
    
    private func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    private func pop() {
        navigationController.popToRootViewController(animated: true)
    }
    
    private func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }

    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
