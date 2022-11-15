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
        navigationController.setToolbarHidden(true, animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window = UIWindow(windowScene: winScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let url = URL(string: "http://kobar.up.railway.app")
        lazy var authDataSource = Auth0DataSource.shared
        lazy var socketDataSource = SocketIODataSource(url: url)
        lazy var findBattleService = FindBattleDataSource(socketService: socketDataSource)
        lazy var authService = AuthDataSource(authDataSource, socketDataSource)
        
        let authViewModel = AuthViewModel(service: authService)
        let authCoordinator = AuthCoordinator(
            navigationController,
            viewModel: authViewModel,
            makeLoading: { LoadingPageViewController() },
            makeSignIn: {
                let svc = SignInPageViewController()
                svc.onSignIn = authService.login
                svc.onSignUp = authService.signUp
                return svc
            },
            makeMain: { authc, user in
                let mvc = MainPageViewController()
                mvc.rating = user.rating
                mvc.picture = user.picture
                mvc.onInviteFriend = {
                    findBattleService.getBattleInvitation(userId: user.id)
                    let ifvm = InviteFriendViewModel(service: findBattleService)
                    let ifc = InviteFriendCoordinator(
                        navigationController,
                        viewModel: ifvm,
                        makeBattleInvitation: { ifc, battleInvitation in
                            let ifvc = InviteFriendPageViewController()
                            ifvc.inviteCode = battleInvitation.inviteCode
                            ifvc.name = user.nickname
                            ifvc.rating = user.rating
                            ifvc.picture = user.picture
                            ifvc.onBack = ifc.completion
                            return ifvc
                        },
                        makeBattle: { preStartBattle in
                            let battleService = BattleDataSource(
                                socketService: socketDataSource,
                                preStartBattle: preStartBattle)
                            let bvm = BattleViewModel(service: battleService)
                            let battlec = BattleCoordinator(
                                navigationController,
                                viewModel: bvm,
                                makeCountdown: { battle in
                                    let rfbvc = ReadyForBattlePageViewController()
                                    rfbvc.userName = user.nickname
                                    rfbvc.userRating = user.rating
                                    rfbvc.userPicture = user.picture
                                    if let opp = battle.users.first(where: { $0.id != user.id }) {
                                        rfbvc.opponentName = opp.nickname
                                        rfbvc.opponentRating = opp.rating
                                        rfbvc.opponentPicture = opp.picture
                                    }
                                    rfbvc.onBack = { battleService.cancelBattle(battleId: battle.id) }
                                    rfbvc.onReady = {
                                        battleService.startBattle(
                                            userId: user.id,
                                            battleId: battle.id)
                                    }
                                    rfbvc.onCountdownFinished = {
                                        battleService.startBattle(
                                            userId: user.id,
                                            battleId: battle.id)
                                    }
                                    return rfbvc
                                },
                                makeBattle: { battle in
                                    let bvc = BattlefieldPageViewController()
                                    bvc.userName = user.nickname
                                    if let opp = battle.users.first(where: { $0.id != user.id }) {
                                        bvc.opponentName = opp.nickname
                                    }
                                    if let prob = battle.problem {
                                        bvc.problem = prob
                                    }
                                    bvc.battleEndDate = battle.endTime
                                    bvc.onRunCode = { submission in }
                                    bvc.onSubmitCode = { submission in }
                                    bvc.onShowDocumentation = {}
                                    return bvc
                                }
                            )
                            return battlec
                        })
                    authc.startNextCoordinator(ifc)
                }
                mvc.onJoinFriend = {
                }
                mvc.onLogout = {
                    authService.logout()
                    socketDataSource.disconnect()
                }
                return mvc
            })
        
        coordinator = authCoordinator
        coordinator?.start()
        
        authService.getUser()
    }
}
