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

        let factory = AppFactory()
        let navigationController = UINavigationController()

        window = UIWindow(windowScene: winScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()


        let authCoordinator = factory.makeAuthCoordinator(navigationController)

        coordinator = authCoordinator
        coordinator?.start()
    }
}
