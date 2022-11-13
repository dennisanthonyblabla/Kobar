//
//  SceneDelegate.swift
//  MacroChallengeTeam2
//
//  Created by Dennis Anthony on 06/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let winScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController()

        window = UIWindow(windowScene: winScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        let url = URL(string: "http://kobar.up.railway.app")
        let authService = RxSwiftAuthAdapter(Auth0DataSource.shared, SocketIODataSource(url: url))
        let socketService = SocketIODataSource(url: url)

        let authCoordinator = makeAuthCoordinator(
            navigationController,
            authService: authService,
            socketService: socketService)

        authCoordinator.goToJoinFriendCoordinator = { user in
            let findBattleCoordinator = self.makeFindBattleCoordinator(
                navigationController,
                socketService: socketService,
                battleAction: .joinFriend,
                user: user)

            findBattleCoordinator.makeNextCoordinator = { user, battle in
                self.makeBattleCoordinator(
                    navigationController,
                    socketService: socketService,
                    user: user,
                    battle: battle)
            }

            return findBattleCoordinator
        }

        authCoordinator.goToInviteFriendCoordinator = { user in
            let findBattleCoordinator = self.makeFindBattleCoordinator(
                navigationController,
                socketService: socketService,
                battleAction: .inviteFriend,
                user: user)

            findBattleCoordinator.makeNextCoordinator = { user, battle in
                self.makeBattleCoordinator(
                    navigationController,
                    socketService: socketService,
                    user: user,
                    battle: battle)
            }

            return findBattleCoordinator
        }

        coordinator = authCoordinator
        coordinator?.start()
    }

    // MARK: Composition Root

    func makeAuthCoordinator(
        _ navigationController: UINavigationController,
        authService: AuthService,
        socketService: SocketIODataSource
    ) -> AuthCoordinator {
        let viewModel = AuthViewModel(service: authService)
        let coordinator = AuthCoordinator(navigationController, viewModel: viewModel)
        return coordinator
    }

    func makeFindBattleCoordinator(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
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

    func makeBattleCoordinator(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
        user: User,
        battle: Battle
    ) -> BattleCoordinator {
        let coordinator = BattleCoordinator(
            navigationController,
            socketService: socketService,
            user: user,
            battle: battle)

        return coordinator
    }
}
