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
            makeSignIn: { [unowned self] in
                let svc = SignInPageViewController()
                svc.onSignIn = self.authService.login
                svc.onSignUp = self.authService.signUp
                return svc
            },
            makeMain: { [unowned self] authc, user in
                let mvc = MainPageViewController()
                mvc.rating = user.rating
                mvc.picture = user.picture
                mvc.onInviteFriend = {
                    let ifc = self.makeInviteFriendCoordinator(
                        navigationController,
                        user: user)
                    authc.startNextCoordinator(ifc)
                }
                mvc.onJoinFriend = {
                    let jfc = self.makeJoinFriendCoordinator(
                        navigationController,
                        user: user)
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
            makeBattleInvitation: { battleInvitation in
                let ifvc = InviteFriendPageViewController()
                ifvc.inviteCode = battleInvitation.inviteCode
                ifvc.name = user.nickname
                ifvc.rating = user.rating
                ifvc.picture = user.picture
                ifvc.onBack = { [weak ifvm] in
                    ifvm?.cancelBattleInvitation()
                }
                ifvc.onShare = {}
                return ifvc
            },
            makeReadyForBattle: { [unowned self] battle in
                self.makeReadyForBattlePageViewController(user: user, battle: battle) {
                    ifvm.cancelBattle()
                }
            },
            makeBattle: { [unowned self] battle in
                self.makeBattleCoordinator(navigationController, user: user, battle: battle)
            })
        
        return ifc
    }
    
    func makeJoinFriendCoordinator(_ navigationController: UINavigationController, user: User) -> JoinFriendCoordinator {
        let jfvm = JoinFriendViewModel(service: findBattleService, userId: user.id)
        let jfc = JoinFriendCoordinator(
            navigationController,
            viewModel: jfvm,
            makeJoinFriend: {
                let jfvc = JoinFriendPageViewController()
                jfvc.onConfirm = { [weak jfvm] inviteCode in
                    jfvm?.joinFriend(inviteCode: inviteCode)
                }
                jfvc.onCancel = { [weak jfvm] in
                    jfvm?.cancelJoinBattle()
                }
                return jfvc
            },
            makeReadyForBattle: { [unowned self] battle in
                self.makeReadyForBattlePageViewController(user: user, battle: battle) {
                    jfvm.cancelBattle()
                }
            },
            makeBattle: { [unowned self] battle in
                self.makeBattleCoordinator(navigationController, user: user, battle: battle)
            })
        
        return jfc
    }
    
    func makeBattleCoordinator(
        _ navigationController: UINavigationController,
        user: User,
        battle: Battle
    ) -> BattleCoordinator {
        let battlevm = BattleViewModel(service: battleService, battle: battle, userId: user.id)
        let battlec = BattleCoordinator(
            navigationController,
            viewModel: battlevm,
            makeBattle: { battle in
                let bvc = BattlefieldPageViewController()
                bvc.userName = user.nickname
                bvc.battleEndDate = battle.endTime
                bvc.onShowDocumentation = battlevm.showDocumentation
                if let opp = battle.users.first(where: { $0.id != user.id }) {
                    bvc.opponentName = opp.nickname
                }
                if let prob = battle.problem {
                    bvc.problem = prob
                    bvc.onRunCode = { [weak battlevm] submission in
                        battlevm?.runCode(submission: submission, problemId: prob.id)
                    }
                    bvc.onSubmitCode = { [weak battlevm] submission in
                        battlevm?.submitCode(submission: submission, problemId: prob.id)
                    }
                }
                return bvc
            },
            makeDocumentation: {
                let docvc = DokumentasiPageVC()
                docvc.onClose = battlevm.hideDocumentation
                return docvc
            },
            makeEndBattle: { [unowned self] result in
                self.makeEndBattleCoordinator()
            })
        
        return battlec
    }
    
    func makeEndBattleCoordinator() -> EndBattleCoordinator {
        let endbc = EndBattleCoordinator()
        return endbc
    }
    
    func makeReadyForBattlePageViewController(
        user: User,
        battle: Battle,
        completion: @escaping () -> Void
    ) -> ReadyForBattlePageViewController {
        let rfbvc = ReadyForBattlePageViewController()
        rfbvc.userName = user.nickname
        rfbvc.userRating = user.rating
        rfbvc.userPicture = user.picture
        if let opp = battle.users.first(where: { $0.id != user.id }) {
            rfbvc.opponentName = opp.nickname
            rfbvc.opponentRating = opp.rating
            rfbvc.opponentPicture = opp.picture
        }
        rfbvc.battleStartDate = battle.startTime
        rfbvc.onBack = completion
        rfbvc.onCountdownFinished = completion
        // TODO: @salman move to vm?
        rfbvc.onReady = { [unowned self] in
            self.battleService.startBattle(
                userId: user.id,
                battleId: battle.id)
        }
        return rfbvc
    }
}
