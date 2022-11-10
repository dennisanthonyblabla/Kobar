//
//  MainCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit
import RxSwift

/// Responsible for navigation when onAuthStateChanged is called
// TODO: @salman give this proper state mgmt handling
final class AuthCoordinator: BaseCoordinator {
    // TODO: @salman i think there's a better way to do this, but for now isoke
    var goToInviteFriendCoordinator: ((User) -> Coordinator)?
    var goToJoinFriendCoordinator: ((User) -> Coordinator)?
    
    private let navigationController: UINavigationController
    
    private let authViewModel: AuthViewModel
    private let userViewModel: UserViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        _ navigationController: UINavigationController,
        authService: AuthService,
        socketService: SocketIODataSource
    ) {
        self.navigationController = navigationController
        
        self.authViewModel = AuthViewModel(authService)
        self.userViewModel = UserViewModel(socketHandler: socketService)
    }
    
    override func start() {
        show(makeLoadingPageViewController())
        
        // Bind auth coordinator with auth state from view model
        authViewModel.authState()
            .observe(on: MainScheduler.instance)
            .distinctUntilChanged { $0?.id == $1?.id }
            .subscribe { [weak self] in
                self?.onAuthStateChanged($0)
            }
            .disposed(by: disposeBag)
    }
    
    func onAuthStateChanged(_ authUser: AuthUser?) {
        guard let authUser = authUser else {
            replace(with: makeSignInPageViewController())
            return
        }
        
        // Bind to userId exchange state from view model
        userViewModel.connect(for: authUser)
            .andThen(userViewModel.exchangeId(from: authUser))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] user in
                guard let viewController = self?.makeMainPageViewController(with: user) else { return }
                self?.replace(with: viewController)
            }
            .disposed(by: disposeBag)
    }
    
    func makeLoadingPageViewController() -> LoadingPageViewController {
        LoadingPageViewController()
    }
    
    func makeSignInPageViewController() -> SignInPageViewController {
        let signInVC = SignInPageViewController()
        
        signInVC.onSignIn = { [weak self] in
            self?.authViewModel.login()
        }
        
        signInVC.onSignUp = { [weak self] in
            self?.authViewModel.signUp()
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
            self?.authViewModel.logout()
            self?.userViewModel.disconnect()
        }
        
        return mainVC
    }
    
    private func replace(with viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: true)
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
