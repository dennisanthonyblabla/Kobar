//
//  BattleCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import RxSwift

final class BattleCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    
    private let startBattleViewModel: StartBattleViewModel
    private let battleViewModel: BattleViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
        user: User,
        battle: Battle
    ) {
        self.navigationController = navigationController
        self.startBattleViewModel = StartBattleViewModel(
            socketService: socketService,
            user: user,
            battle: battle)
        self.battleViewModel = BattleViewModel(
            socketService: socketService,
            user: user,
            battle: battle)
    }
    
    override func start() {
        startBattleViewModel.battleState()
            .distinctUntilChanged { $0.status == $1.status }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] state in
                self?.onStartBattleStateChanged(state)
            }
            .disposed(by: disposeBag)
        
        battleViewModel.battleStatus()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] status in
                self?.onBattleStatusChanged(status)
            }
            .disposed(by: disposeBag)
    }
    
    func onStartBattleStateChanged(_ state: StartBattleState) {
        switch state.status {
        case .pending:
            let readyVC = makeReadyForBattlePageViewController(user: state.user, with: state.battle)
            show(readyVC)
        case .started:
            let battleVC = makeBattlefieldPageViewController(state)
            replaceAllExceptRoot(with: battleVC)
        case .canceled:
            pop()
            completion?()
        }
    }
    
    func onBattleStatusChanged(_ state: BattleState) {
        switch state.status {
        case .ongoing:
            break
        case let .waitingForOpponent(result):
            let doneVC = makeBattleDoneViewController(result, state.battle.endTime)
            replace(with: doneVC)
        case let .battleFinished(result):
            let resultVC = makeBattleResultViewController(state.user, state.battle, result)
            replaceAllExceptRoot(with: resultVC)
        }
    }
    
    func makeReadyForBattlePageViewController(
        user: User,
        with battle: Battle
    ) -> ReadyForBattlePageViewController {
        let readyVC = ReadyForBattlePageViewController()
        
        readyVC.user = user
        readyVC.opponent = battle.users.first { user.id != $0.id } ?? .empty()
        
        readyVC.onBack = { [weak self] in
            self?.startBattleViewModel.cancel()
            self?.pop()
        }
        
        readyVC.onReady = { [weak self] in
            self?.startBattleViewModel.start()
        }
        
        readyVC.onCountdownFinished = { [weak self] in
            self?.startBattleViewModel.start()
        }
        
        readyVC.battleStartDate = battle.startTime
        
        return readyVC
    }
    
    func makeBattlefieldPageViewController(_ state: StartBattleState) -> BattlefieldPageViewController {
        let battleVC = BattlefieldPageViewController()
        
        battleVC.userName = state.user.nickname
        battleVC.opponentName =
            state.battle.users.first { state.user.id != $0.id }?.nickname ?? ""
        
        battleVC.battleEndDate = state.battle.endTime
        
        if let problem = state.battle.problem {
            battleVC.problem = problem

            battleVC.onRunCode = { [weak self] submission in
                self?.battleViewModel.runCode(problemId: problem.id, submission: submission)
            }
            
            battleVC.onSubmitCode = { [weak self] submission in
                self?.battleViewModel.submitCode(problemId: problem.id, submission: submission)
            }
        }
        
        battleVC.onShowDocumentation = {
            let docVC = self.makeDocumentationViewController()
            self.present(docVC)
        }
        
        battleViewModel.runCodeState()
            .distinctUntilChanged { $0.output }
            .observe(on: MainScheduler.instance)
            .subscribe { runCodeResult in
                battleVC.updateRunCodeResult(result: runCodeResult)
            }
            .disposed(by: disposeBag)
        
        return battleVC
    }
    
    func makeBattleDoneViewController(_ result: SubmitCodeResult, _ endDate: Date) -> BattleDoneVC {
        let doneVC = BattleDoneVC()
        
        doneVC.onComplete = {
            self.replace(with: self.makeTestCaseViewController(result, endDate))
        }
        
        return doneVC
    }
    
    func makeTestCaseViewController(_ result: SubmitCodeResult, _ endDate: Date) -> TestCaseViewController {
        let testVC = TestCaseViewController()
        
        testVC.submitCodeResult = result
        
        testVC.onNext = {
            self.replace(with: self.makeWaitingRoomViewController(endDate))
        }
        
        return testVC
    }
    
    func makeWaitingRoomViewController(_ endDate: Date) -> TungguLawanViewController {
        let waitVC = TungguLawanViewController()
        
        waitVC.endDate = endDate
        
        waitVC.onNewBattle = {
            self.popToRoot()
        }
        
        waitVC.onShowDiscussion = {
            let reviewVC = self.makeReviewViewController()
            self.show(reviewVC)
        }
        
        return waitVC
    }
    
    func makeDocumentationViewController() -> UIViewController {
        let controller = UIViewController()
        let view = DokumentasiView()
        
        controller.view = DokumentasiView()
        
        // TODO: button not working
        view.onClose = { [weak self, controller] in
            controller.dismiss(animated: true)
            self?.navigationController.dismiss(animated: true)
        }
        
        return controller
    }
    
    func makeBattleResultViewController(
        _ user: User,
        _ battle: Battle,
        _ result: BattleResult
    ) -> HasilTandingPageViewController {
        let resultVC = HasilTandingPageViewController()

        resultVC.user = user
        resultVC.opponent = battle.users.first { $0.id != user.id } ?? .empty()
        
        resultVC.testCases = battle.problem?.testCases.count ?? 0
        
        resultVC.result = result
        
        resultVC.onFinish = {
            self.popToRoot()
        }
        
        resultVC.onShowDiscussion = {
            let reviewVC = self.makeReviewViewController()
            self.show(reviewVC)
        }
        
        return resultVC
    }
    
    func makeReviewViewController() -> PembahasanViewController {
        let pembahasanVC = PembahasanViewController()
        
        pembahasanVC.code = battleViewModel.code
        pembahasanVC.reviewText = battleViewModel.problem.reviewText
        pembahasanVC.reviewVideoURL = battleViewModel.problem.reviewVideoURL
        
        pembahasanVC.onBack = {
            self.pop()
        }
        
        return pembahasanVC
    }
    
    private func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }
    
    private func replaceAllExceptRoot(with viewController: UIViewController) {
        guard navigationController.viewControllers.count > 1 else { return }
        
        let viewControllers = [navigationController.viewControllers[0], viewController]
        
        navigationController.setViewControllers(viewControllers, animated: true)
    }
    
    private func replace(with viewController: UIViewController) {
        let count = navigationController.viewControllers.count
        let viewControllers: [UIViewController] =
            navigationController.viewControllers[..<(count - 1)] + [viewController]
        
        navigationController.setViewControllers(viewControllers, animated: true)
    }
    
    private func popToRoot() {
        navigationController.popToRootViewController(animated: true)
        completion?()
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
