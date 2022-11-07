//
//  MainCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit
import RxSwift

final class MainCoordinator {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    private let disposeBag = DisposeBag()

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start(authService: AuthService) {
        let userSubject = BehaviorSubject<User?>(value: nil)

        authService.getUser { user in
            userSubject.onNext(user)
        }

        userSubject
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] (user: User?) in
                guard let strongSelf = self else { return }

                guard let user = user else {
                    let signInVC = strongSelf.factory.signInViewController { loginUser in
                        userSubject.onNext(loginUser)
                    }
                    strongSelf.show(signInVC)
                    return
                }

                let mainPageVC = strongSelf.factory.mainPageViewController(for: user)
                strongSelf.show(mainPageVC)
            }
            .disposed(by: disposeBag)
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }

    private func replace(_ viewController: UIViewController) {
        navigationController.popViewController(animated: true)
        navigationController.pushViewController(viewController, animated: true)
    }
}
