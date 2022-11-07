//
//  ViewControllerFactory.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit

final class ViewControllerFactory {
    let authService: AuthService

    init(authRepository: AuthService) {
        self.authService = authRepository
    }

    func mainPageViewController(for user: User) -> MainPageViewController {
        let mainPageVC = MainPageViewController()
        return mainPageVC
    }

    func signInViewController(loginCallback: @escaping (User?) -> Void) -> SignInViewController {
        let signInVC = SignInViewController()

        signInVC.onSignIn = {
            self.authService.login { user in
                loginCallback(user)
            }
        }

        return signInVC
    }
}
