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

        let navigationController = UINavigationController(rootViewController: SnippetKeyboardVC())
        navigationController.setNavigationBarHidden(true, animated: true)

        window = UIWindow(windowScene: winScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        let url = URL(string: "http://kobar.up.railway.app")
        let authService = Auth0DataSource.shared
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
//        coordinator?.start()
    }

    // MARK: Composition Root

    func makeAuthCoordinator(
        _ navigationController: UINavigationController,
        authService: AuthService,
        socketService: SocketIODataSource
    ) -> AuthCoordinator {
        let coordinator = AuthCoordinator(
            navigationController,
            authService: authService,
            socketService: socketService)

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

// MARK: Unused SceneDelegate Methods

/*

func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

*/
