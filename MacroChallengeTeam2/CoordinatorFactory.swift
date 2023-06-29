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
    lazy var endBattleService = EndBattleDataSource(socketService: socketDataSource)
    
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
                    guard authc.childCoordinators.isEmpty else { return }
                    let ifc = self.makeInviteFriendCoordinator(
                        navigationController,
                        user: user)
                    authc.startNextCoordinator(ifc)
                }
                mvc.onJoinFriend = {
                    guard authc.childCoordinators.isEmpty else { return }
                    let jfc = self.makeJoinFriendCoordinator(
                        navigationController,
                        user: user)
                    authc.startNextCoordinator(jfc)
                }
                mvc.onJoinRandom = {
                    guard authc.childCoordinators.isEmpty else { return }
                    let jrc = self.makeJoinRandomCoordinator(navigationController, user: user)
                    authc.startNextCoordinator(jrc)
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
            makeReadyForBattle: { [unowned self, weak ifvm] battle in
                self.makeReadyForBattlePageViewController(user: user, battle: battle) {
                    ifvm?.cancelBattle()
                }
            },
            makeBattle: { [unowned self] battle in
                self.makeBattleCoordinator(navigationController, user: user, battle: battle)
            })
        
        return ifc
    }
    
    func makeJoinRandomCoordinator(_ navigationController: UINavigationController, user: User) -> JoinRandomCoordinator {
        let jrvm = JoinRandomViewModel(service: findBattleService, userId: user.id)
        let jrc = JoinRandomCoordinator(
            navigationController,
            viewModel: jrvm,
            makeJoinRandom: {
                let jrvc = JoinRandomPageViewController()
                jrvc.onConfirm = { [weak jrvm] inviteCode in
                    jrvm?.joinFriend(inviteCode: inviteCode)
                }
                jrvc.onCancel = { [weak jrvm] in
                    jrvm?.cancelJoinBattle()
                }
                return jrvc
            },
            makeReadyForBattle: { [unowned self, weak jrvm] battle in
                self.makeReadyForBattlePageViewController(user: user, battle: battle) {
                    jrvm?.cancelBattle()
                }
            },
            makeBattle: { [unowned self] battle in
                self.makeBattleCoordinator(navigationController, user: user, battle: battle)
            })
        
        return jrc
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
            makeReadyForBattle: { [unowned self, weak jfvm] battle in
                self.makeReadyForBattlePageViewController(user: user, battle: battle) {
                    jfvm?.cancelBattle()
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
        let rcvm = RunCodeViewModel(service: battleService, userId: user.id, battleId: battle.id)
        let battlec = BattleCoordinator(
            navigationController,
            viewModel: battlevm,
            makeBattle: { [weak battlevm] battle in
                let bvc = BattlefieldPageViewController()
                bvc.userName = user.nickname
                bvc.battleEndDate = battle.endTime
                bvc.onShowDocumentation = {
                    battlevm?.showDocumentation()
                }
                bvc.opponentName = battlevm?.opponentName ?? ""
                if let prob = battle.problem {
                    bvc.problem = prob
                    bvc.runCodeViewModel = rcvm
                    bvc.onSubmitCode = { submission in
                        battlevm?.submitCode(submission: submission, problemId: prob.id)
                    }
                }
                return bvc
            },
            makeDocumentation: { [weak battlevm] in
                let docvc = DokumentasiPageVC()
                docvc.onClose = {
                    battlevm?.hideDocumentation()
                }
                return docvc
            },
            makeEndBattle: { [unowned self] submitCodeResult, battleResult in
                self.makeEndBattleCoordinator(
                    navigationController,
                    user: user,
                    battle: battle,
                    submitCodeResult: submitCodeResult,
                    battleResult: battleResult)
            })
        
        return battlec
    }
    
    func makeEndBattleCoordinator(
        _ navigationController: UINavigationController,
        user: User,
        battle: Battle,
        submitCodeResult: SubmitCodeResult,
        battleResult: BattleResult?
    ) -> EndBattleCoordinator {
        let endvm = EndBattleViewModel(
            service: endBattleService,
            submitCodeResult: submitCodeResult,
            battleResult: battleResult)
        let endbc = EndBattleCoordinator(
            navigationController,
            viewModel: endvm,
            makeBattleDone: { [weak endvm] in
                let bdvc = BattleDoneVC()
                bdvc.onComplete = {
                    endvm?.toTestCase()
                }
                return bdvc
            },
            makeTestCase: { [weak endvm] submitCodeResult in
                let tcvc = TestCaseViewController()
                tcvc.onNext = {
                    endvm?.toWaiting()
                }
                tcvc.tests = submitCodeResult.tests
                return tcvc
            },
            makeWaitingForOpponentFinish: {
                let tlvc = TungguLawanViewController()
                tlvc.endDate = battle.endTime
                tlvc.onShowReview = { [weak endvm] in
                    endvm?.toReview()
                }
                tlvc.onNewBattle = { [weak endvm] in
                    endvm?.toFinishBattle()
                }
                return tlvc
            },
            makeBattleReview: { battleReview in
                let pvc = PembahasanViewController()
                pvc.reviewVideoURL = battleReview.reviewVideoURL
                pvc.reviewText = battleReview.reviewText
                pvc.code = submitCodeResult.code
                pvc.onBack = { [weak endvm] in
                    endvm?.backFromReview()
                }
                return pvc
            },
            makeBattleResult: { battleResult in
                let htvm = BattleResultViewModel(battle: battle, result: battleResult, user: user)
                let htvc = HasilTandingPageViewController()
                htvc.viewModel = htvm
                htvc.onShowReview = { [weak endvm] in
                    endvm?.toReview()
                }
                htvc.onFinish = { [weak endvm] in
                    endvm?.toFinishBattle()
                }
                return htvc
            })
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
