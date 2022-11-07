//
//  MainCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> Void)?

    private let navigationController: UINavigationController
    private let authRepository: AuthRepositoryListenableAdapter

    init(_ navigationController: UINavigationController, authRepository: AuthRepositoryListenableAdapter) {
        self.navigationController = navigationController
        self.authRepository = authRepository
    }

    func start() {
        showLoadingVC()

        // Delay loading page by at least 1 second so its not too fast
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now().advanced(by: .seconds(1)),
            execute: ({ [weak self] in
                self?.listenToAuthState()
            })
        )
    }

    private func listenToAuthState() {
        authRepository.onAuthStateChanged { [weak self] user in
            guard let user = user else {
                self?.showSignInVC()
                return
            }

            self?.showMainVC(user)
        }
    }

    private func showLoadingVC() {
        let loadingPageVC = LoadingPageVC()
        navigationController.pushViewController(loadingPageVC, animated: true)
    }

    private func showSignInVC() {
        let signInPageVC = SignInPageViewController()

        signInPageVC.onSignIn = { [weak self] in
            self?.authRepository.login()
        }

        signInPageVC.onSignUp = { [weak self] in
            self?.authRepository.signUp()
        }

        navigationController.pushViewController(signInPageVC, animated: true)
    }

    private func showMainVC(_ user: User) {
        let mainPageVC = MainPageViewController()
        navigationController.pushViewController(mainPageVC, animated: true)
    }
}
