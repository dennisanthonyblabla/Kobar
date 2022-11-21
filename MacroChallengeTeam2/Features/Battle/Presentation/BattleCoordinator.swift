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
    private let makeEndBattle: (SubmitCodeResult, BattleResult?) -> Coordinator
    private let previousStack: [UIViewController]
    
    init(
        _ navigationController: UINavigationController,
        viewModel: BattleViewModel,
        makeBattle: @escaping (Battle) -> UIViewController,
        makeDocumentation: @escaping () -> UIViewController,
        makeEndBattle: @escaping (SubmitCodeResult, BattleResult?) -> Coordinator
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
        self.makeBattle = makeBattle
        self.makeDocumentation = makeDocumentation
        self.makeEndBattle = makeEndBattle
        
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        viewModel.state
            .subscribe { [weak self] in self?.onStateChanged($0) }
            .disposed(by: disposeBag)
        
        viewModel.documentationState
            .subscribe { [weak self] in self?.onDocumentationStateChanged($0) }
            .disposed(by: disposeBag)
    }
    
    private func onStateChanged(_ state: BattleViewModel.State) {
        switch state {
        case let .battle(battle):
            show(makeBattle(battle))
        case let .finished(submitCodeResult, battleResult):
            startAndReplaceNextCoordinator(makeEndBattle(submitCodeResult, battleResult))
        }
    }
    
    private func onDocumentationStateChanged(_ state: BattleViewModel.DocumentationState) {
        switch state {
        case .opened:
            present(makeDocumentation())
        case .closed:
            dismiss()
        }
    }
    
    private func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    private func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
