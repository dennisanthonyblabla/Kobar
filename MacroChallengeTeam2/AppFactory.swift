//
//  AppFactory.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 14/11/22.
//

import UIKit

class AppFactory {
    let url = URL(string: "http://kobar.up.railway.app")
    private lazy var authService = AuthDataSource(Auth0DataSource.shared, SocketIODataSource(url: url))
    private lazy var socketService = SocketIODataSource(url: url)
    
    init() {
        authService.getUser()
    }
    
    func makeAuthCoordinator(_ navigationController: UINavigationController) -> AuthCoordinator {
        let viewModel = AuthViewModel(service: authService)
        let coordinator = AuthCoordinator(
            navigationController,
            viewModel: viewModel,
            makeLoading: { self.makeLoadingPageViewController() },
            makeSignIn: { self.makeSignInPageViewController() },
            makeMain: { user in self.makeMainPageViewController(with: user) }
        )
        return coordinator
    }

    func makeFindBattleCoordinator(
        _ navigationController: UINavigationController,
        battleAction: FindBattleCoordinator.BattleAction,
        user: User
    ) -> FindBattleCoordinator {
        let coordinator = FindBattleCoordinator(
            navigationController,
            socketService: socketService,
            battleAction: battleAction,
            user: user)

        return coordinator
    }

    func makeBattleCoordinator(_ navigationController: UINavigationController, user: User, battle: Battle) -> BattleCoordinator {
        let coordinator = BattleCoordinator(
            navigationController,
            socketService: socketService,
            user: user,
            battle: battle)

        return coordinator
    }
    
    func makeLoadingPageViewController() -> LoadingPageViewController {
        LoadingPageViewController()
    }
    
    func makeSignInPageViewController() -> SignInPageViewController {
        let viewModel = AuthViewModel(service: authService)
        let signInVC = SignInPageViewController()
        
        signInVC.onSignIn = { [weak self] in
            self?.authService.login()
        }
        
        signInVC.onSignUp = { [weak self] in
            self?.authService.signUp()
        }
        
        return signInVC
    }
    
    func makeMainPageViewController(with user: User) -> MainPageViewController {
        let mainVC = MainPageViewController()
        
        mainVC.user = user
        
        mainVC.onInviteFriend = { [weak self] in
//            guard let coordinator = self?.goToInviteFriendCoordinator?(user) else { return }
//            self?.startNextCoordinator(coordinator)
        }
        
        mainVC.onJoinFriend = { [weak self] in
//            guard let coordinator = self?.goToJoinFriendCoordinator?(user) else { return }
//            self?.startNextCoordinator(coordinator)
        }
        
        mainVC.onLogout = { [weak self] in
            self?.authService.logout()
            self?.socketService.disconnect()
        }
        
        return mainVC
    }
}
