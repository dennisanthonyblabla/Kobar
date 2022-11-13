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
    // TODO: @salman i think there's a better way to do this, but for now isoke
    var goToInviteFriendCoordinator: ((User) -> Coordinator)?
    var goToJoinFriendCoordinator: ((User) -> Coordinator)?
    
    let navigationController: UINavigationController
    private let viewModel: AuthViewModel
    private let disposeBag = DisposeBag()
    
    init(_ navigationController: UINavigationController, viewModel: AuthViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    override func start() {
        // Bind auth coordinator with auth state from view model
        viewModel.state
            .subscribe { [weak self] in self?.onAuthStateChanged($0) }
            .disposed(by: disposeBag)
    }
    
    func onAuthStateChanged(_ state: AuthViewModel.State) {
        switch state {
        case .loading:
            setRootViewController(makeLoadingPageViewController())
        case .unauthenticated:
            setRootViewController(makeSignInPageViewController())
        case let .authenticated(user):
            setRootViewController(makeMainPageViewController(with: user))
        }
    }
    
    func makeLoadingPageViewController() -> LoadingPageViewController {
        LoadingPageViewController()
    }
    
    func makeSignInPageViewController() -> SignInPageViewController {
        let signInVC = SignInPageViewController()
        
        signInVC.onSignIn = { [weak self] in
//            self?.authService.login()
        }
        
        signInVC.onSignUp = { [weak self] in
//            self?.authService.signUp()
        }
        
        return signInVC
    }
    
    func makeMainPageViewController(with user: User) -> MainPageViewController {
        let mainVC = MainPageViewController()
        
        mainVC.user = user
        
        mainVC.onInviteFriend = { [weak self] in
            guard let coordinator = self?.goToInviteFriendCoordinator?(user) else { return }
            self?.startNextCoordinator(coordinator)
        }
        
        mainVC.onJoinFriend = { [weak self] in
            guard let coordinator = self?.goToJoinFriendCoordinator?(user) else { return }
            self?.startNextCoordinator(coordinator)
        }
        
        mainVC.onLogout = { [weak self] in
//            self?.authService.logout()
//            self?.userViewModel.disconnect()
        }
        
        return mainVC
    }

    private func setRootViewController(_ viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: true)
    }
}
