//
//  MainCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    typealias AuthListenableRepository = AuthRepository & AuthListenable

    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> Void)?

    private let navigationController: UINavigationController
    private let authRepository: AuthListenableRepository

    init(_ navigationController: UINavigationController, authRepository: AuthListenableRepository) {
        self.navigationController = navigationController
        self.authRepository = authRepository
    }

    func start() {
        authRepository.onAuthStateChanged { [weak self] user in
            guard let user = user else {
                self?.showSignInVC()
                return
            }

            self?.showMainVC(user)
        }
    }

    private func showSignInVC() {
        let signInVC = SignInViewController()

        signInVC.onSignIn = { [weak self] in
            self?.authRepository.login { _ in }
        }

        signInVC.onSignUp = { [weak self] in
            self?.authRepository.signUp { _ in }
        }

        navigationController.pushViewController(signInVC, animated: true)
    }

    private func showMainVC(_ user: User) {
        let mainVC = MainPageViewController()
        navigationController.pushViewController(mainVC, animated: true)
    }
}
