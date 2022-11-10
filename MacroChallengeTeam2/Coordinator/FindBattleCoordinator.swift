//
//  BattleCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import UIKit
import RxSwift

final class FindBattleCoordinator: BaseCoordinator {
    var makeNextCoordinator: ((User, Battle) -> Coordinator)?
    
    enum BattleAction {
        case inviteFriend, joinFriend, joinRandom
    }
    
    private let navigationController: UINavigationController

    private let battleAction: BattleAction
    
    private let findBattleViewModel: FindBattleViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
        battleAction: BattleAction,
        user: User
    ) {
        self.navigationController = navigationController
        self.findBattleViewModel = FindBattleViewModel(
            socketService: socketService,
            user: user)
        self.battleAction = battleAction
    }
    
    // TODO: Show loading state
    // TODO: implement join random battle
    override func start() {
        switch battleAction {
        case .inviteFriend:
            onInviteFriend()
        case .joinFriend:
            onJoinFriend()
        case .joinRandom:
            break
        }
        
        findBattleViewModel.playersFoundState()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] user, battle in
                guard let coordinator = self?.makeNextCoordinator?(user, battle)
                else { return }
                self?.startNextCoordinator(coordinator)
            }
            .disposed(by: disposeBag)
    }
    
    func onInviteFriend() {
        findBattleViewModel.createBattle()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] user, battleInvitation in
                guard let waitingRoomVC = self?.makeInviteFriendPageViewController(
                    user: user,
                    with: battleInvitation)
                else { return }
                self?.show(waitingRoomVC)
            }
            .disposed(by: disposeBag)
    }
    
    func onJoinFriend() {
        popup(makeJoinFriendPageViewController())
    }

    func makeInviteFriendPageViewController(
        user: User,
        with battleInvitation: BattleInvitation
    ) -> InviteFriendPageViewController {
        let viewController = InviteFriendPageViewController()
        
        viewController.user = user
        viewController.inviteCode = battleInvitation.inviteCode
        
        viewController.onBack = {
            self.pop()
            self.completion?()
        }
        
        return viewController
    }
    
    func makeJoinFriendPageViewController() -> JoinFriendPageViewController {
        let viewController = JoinFriendPageViewController()
    
        viewController.onConfirm = { inviteCode in
            self.findBattleViewModel.joinBattle(inviteCode: inviteCode)
            self.dismiss(viewController)
        }
        
        viewController.onCancel = {
            self.dismiss(viewController)
        }
        
        return viewController
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func popup(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }
    
    private func dismiss(_ viewController: UIViewController) {
        navigationController.dismiss(animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
}
