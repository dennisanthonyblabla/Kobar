//
//  EndBattleCoordinator.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 18/11/22.
//

import UIKit

final class EndBattleCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    private let previousStack: [UIViewController]
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.previousStack = navigationController.viewControllers
    }
    
    override func start() {
        show(TestCaseViewController())
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.setViewControllers(previousStack + [viewController], animated: true)
    }
}
