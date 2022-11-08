//
//  MainCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit
import RxSwift

/// Responsible for navigation when onAuthStateChanged is called
final class AuthCoordinator: BaseCoordinator {
    private var makeLoadingViewController: (() -> UIViewController)
    private var makeLoginViewController: (() -> UIViewController)
    private var makeMainViewController: ((User) -> UIViewController)
    
    private let navigationController: UINavigationController
    
    init(
        _ navigationController: UINavigationController,
        makeLoadingViewController: @escaping (() -> UIViewController),
        makeLoginViewController: @escaping (() -> UIViewController),
        makeMainViewController: @escaping ((User) -> UIViewController)
    ) {
        self.navigationController = navigationController
        self.makeLoadingViewController = makeLoadingViewController
        self.makeLoginViewController = makeLoginViewController
        self.makeMainViewController = makeMainViewController
    }
    
    override func start() {
        // Show loading page
        show(makeLoadingViewController())
    }
    
    func onAuthStateChanged(_ authUser: User?) {
        // Subscribe to auth state
        // If (hasUser) -> show main page
        // Else -> show login page
        guard let user = authUser else {
            show(makeLoginViewController())
            return
        }
        
        show(makeMainViewController(user))
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
