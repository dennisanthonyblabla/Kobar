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
    private let makeBattle: () -> Coordinator
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: JoinFriendViewModel,
        makeBattle: @escaping () -> Coordinator
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.makeBattle = makeBattle
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.joinFriend()
            .subscribe { [weak self] state in self?.onStateChanged(state) }
            .disposed(by: disposeBag)
    }
    
    private func onStateChanged(_ state: JoinFriendViewModel.State) {
        switch state {
        case .loading:
            break
        case .battleFound:
            startNextCoordinator(makeBattle())
        }
    }

    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
