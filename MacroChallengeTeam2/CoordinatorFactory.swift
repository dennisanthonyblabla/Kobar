//
//  CoordinatorFactory.swift
//  Kobar
//
//  Created by Mohammad Alfarisi on 15/11/22.
//

import Foundation
import UIKit

final class CoordinatorFactory {
    let url = URL(string: "http://kobar.up.railway.app")
    lazy var authDataSource = Auth0DataSource.shared
    lazy var socketDataSource = SocketIODataSource(url: url)
    lazy var authService = AuthDataSource(authDataSource, socketDataSource)
    lazy var findBattleService = FindBattleDataSource(socketService: socketDataSource)
    lazy var battleService = BattleDataSource(socketService: socketDataSource)
    
    func makeAuthCoordinator(_ navigationController: UINavigationController) -> AuthCoordinator {
        let authvm = AuthViewModel(service: authService)
        let authc = AuthCoordinator(
            navigationController,
            viewModel: authvm,
            makeLoading: { LoadingPageViewController() },
            makeSignIn: {
                let svc = SignInPageViewController()
                svc.onSignIn = self.authService.login
                svc.onSignUp = self.authService.signUp
                return svc
            },
            makeMain: { authc, user in
                let mvc = MainPageViewController()
                mvc.rating = user.rating
                mvc.picture = user.picture
                mvc.onInviteFriend = {
                    let ifc = self.makeInviteFriendCoordinator(navigationController, user: user)
                    authc.startNextCoordinator(ifc)
                }
                mvc.onJoinFriend = {
                    let jfc = self.makeJoinFriendCoordinator(navigationController, user: user)
                    authc.startNextCoordinator(jfc)
                }
                mvc.onLogout = {
                    self.authService.logout()
                    self.socketDataSource.disconnect()
                }
                return mvc
            })
        return authc
    }
    
    func makeInviteFriendCoordinator(_ navigationController: UINavigationController, user: User) -> InviteFriendCoordinator {
        let ifvm = InviteFriendViewModel(service: findBattleService, userId: user.id)
        let ifc = InviteFriendCoordinator(
            navigationController,
            viewModel: ifvm,
            makeBattleInvitation: { ifc, battleInvitation in
                let ifvc = InviteFriendPageViewController()
                ifvc.inviteCode = battleInvitation.inviteCode
                ifvc.name = user.nickname
                ifvc.rating = user.rating
                ifvc.picture = user.picture
                ifvc.onBack = ifc.pop
                return ifvc
            },
            makeBattle: {
                self.makeBattleCoordinator(navigationController, user: user)
            })
        
        return ifc
    }
    
    func makeJoinFriendCoordinator(_ navigationController: UINavigationController, user: User) -> JoinFriendCoordinator {
        let jfvm = JoinFriendViewModel(service: findBattleService, userId: user.id)
        let jfc = JoinFriendCoordinator(navigationController, viewModel: jfvm) {
            self.makeBattleCoordinator(navigationController, user: user)
        }
        
        return jfc
    }
    
    func makeBattleCoordinator(_ navigationController: UINavigationController, user: User) -> BattleCoordinator {
        let battlevm = BattleViewModel(service: battleService)
        let battlec = BattleCoordinator(
            navigationController,
            viewModel: battlevm,
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
                rfbvc.onBack = { self.battleService.cancelBattle(battleId: battle.id) }
                rfbvc.onReady = {
                    self.battleService.startBattle(
                        userId: user.id,
                        battleId: battle.id)
                }
                rfbvc.onCountdownFinished = {
                    self.battleService.startBattle(
                        userId: user.id,
                        battleId: battle.id)
                }
                return rfbvc
            },
            makeBattle: { battlec, battle in
                let bvc = BattlefieldPageViewController()
                bvc.userName = user.nickname
                bvc.battleEndDate = battle.endTime
                bvc.onShowDocumentation = battlec.showDocumentation
                if let opp = battle.users.first(where: { $0.id != user.id }) {
                    bvc.opponentName = opp.nickname
                }
                if let prob = battle.problem {
                    bvc.problem = prob
                    bvc.onRunCode = { submission in
                        self.battleService.runCode(
                            userId: user.id,
                            battleId: battle.id,
                            problemId: prob.id,
                            submission: submission)
                    }
                    bvc.onSubmitCode = { submission in
                        self.battleService.submitCode(
                            userId: user.id,
                            battleId: battle.id,
                            problemId: prob.id,
                            submission: submission)
                    }
                }
                return bvc
            },
            makeDocumentation: { DokumentasiViewController() })
        
        return battlec
    }
}
