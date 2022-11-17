//
//  BattleCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import RxSwift

final class BattleCoordinator: BaseCoordinator {
    private let viewModel: BattleViewModel
    private let disposeBag = DisposeBag()
    
    private let navigationController: UINavigationController
    private let makeBattle: (Battle) -> UIViewController
    private let makeDocumentation: () -> UIViewController
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: BattleViewModel,
        makeBattle: @escaping (Battle) -> UIViewController,
        makeDocumentation: @escaping () -> UIViewController
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.makeBattle = makeBattle
        self.makeDocumentation = makeDocumentation
        
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.state
            .subscribe { [weak self] state in self?.onStateChanged(state) }
            .disposed(by: disposeBag)
    }
    
    private func onStateChanged(_ state: BattleViewModel.State) {
        switch state {
        case let .battle(battle):
            show(makeBattle(battle))
        }
    }
    
    func showDocumentation() {
        present(makeDocumentation())
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
    
    private func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }
}
