//
//  MainCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit
import RxSwift

final class AuthCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    private let viewModel: AuthViewModel
    
    private let disposeBag = DisposeBag()
    
    init(_ navigationController: UINavigationController, viewModel: AuthViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    override func start() {
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
        viewModel.userSubject
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] user in
                guard let user = user else {
                    self?.showSignInVC()
                    return
                }
                
                self?.showMainVC(user)
            }
            .disposed(by: disposeBag)
    }
    
    private func showLoadingVC() {
        let loadingPageVC = LoadingPageVC()
        navigationController.pushViewController(loadingPageVC, animated: true)
    }
    
    private func showSignInVC() {
        let signInPageVC = SignInPageViewController()
        
        signInPageVC.onSignIn = { [weak self] in
            self?.viewModel.login()
        }
        
        signInPageVC.onSignUp = { [weak self] in
            self?.viewModel.signUp()
        }
        
        navigationController.pushViewController(signInPageVC, animated: true)
    }
    
    private func showMainVC(_ user: User) {
        let mainPageVC = MainPageViewController()
        navigationController.pushViewController(mainPageVC, animated: true)
    }
}
