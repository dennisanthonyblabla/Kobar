//
//  BattleCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import UIKit
import RxSwift

final class BattleCoordinator: BaseCoordinator {
    enum BattleAction {
        case inviteFriend, joinFriend, joinRandom
    }
    
    private let navigationController: UINavigationController
    private let battleAction: BattleAction
    
    private let createBattleViewModel: CreateBattleViewModel
    
    private let disposeBag = DisposeBag()
    
    init(
        _ navigationController: UINavigationController,
        socketService: SocketIODataSource,
        battleAction: BattleAction,
        user: User
    ) {
        self.navigationController = navigationController
        self.createBattleViewModel = CreateBattleViewModel(
            socketService: socketService,
            user: user)
        self.battleAction = battleAction
    }
    
    override func start() {
        show(makeLoadingPageViewController())
        
        switch battleAction {
        case .inviteFriend:
            onInviteFriend()
        case .joinFriend:
            onJoinFriend()
        // TODO: implement join random battle
        case .joinRandom:
            break
        }
    }
    
    func onInviteFriend() {
        createBattleViewModel.battleInvitationSubject
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] user, battleInvitation in
                guard let waitingRoomVC = self?.makeWaitingRoomViewController(
                    user: user,
                    with: battleInvitation)
                else { return }
                self?.show(waitingRoomVC)
            }
            .disposed(by: disposeBag)
        
        createBattleViewModel.createBattle()
    }
    
    func onJoinFriend() {
        
    }

    func makeLoadingPageViewController() -> LoadingPageViewController {
        LoadingPageViewController()
    }

    func makeWaitingRoomViewController(
        user: User,
        with battleInvitation: BattleInvitation
    ) -> RuangTungguViewController {
        let viewController = RuangTungguViewController()
        
        viewController.user = user
        
        viewController.onBack = { [weak self] in
            self?.pop()
            self?.completion?()
        }
        
        return viewController
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func pop() {
        navigationController.popViewController(animated: true)
    }
}
