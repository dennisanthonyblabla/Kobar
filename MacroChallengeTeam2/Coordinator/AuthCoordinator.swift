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
    private let navigationController: UINavigationController
    private let viewModel: AuthViewModel
    private let disposeBag = DisposeBag()
    
    init(_ navigationController: UINavigationController, viewModel: AuthViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    override func start() {
        show(makeLoadingPageViewController())
        
        // Bind auth coordinator with auth state from view model
        viewModel.userSubject
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged { $0?.id == $1?.id }
            .subscribe {
                self.onAuthStateChanged($0)
            }
            .disposed(by: self.disposeBag)
    }
    
    func onAuthStateChanged(_ authUser: AuthUser?) {
        guard let user = authUser else {
            show(makeSignInPageViewController())
            return
        }
        
        show(makeMainPageViewController(with: user))
    }
    
    func makeLoadingPageViewController() -> LoadingPageViewController {
        LoadingPageViewController()
    }
    
    func makeSignInPageViewController() -> SignInPageViewController {
        let viewController = SignInPageViewController()
        
        viewController.onSignIn = { [weak self] in
            self?.viewModel.login()
        }
        
        viewController.onSignUp = { [weak self] in
            self?.viewModel.signUp()
        }
        
        return viewController
    }
    
    func makeMainPageViewController(with user: AuthUser) -> MainPageViewController {
        let viewController = MainPageViewController()
        
        viewController.onLogout = { [weak self] in
            self?.viewModel.logout()
        }
        
        return viewController
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
