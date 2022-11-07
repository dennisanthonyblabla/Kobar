//
//  RxSwiftListenableAuthWrapper.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift

final class RxSwiftAuthWrapper: AuthRepository & AuthListenable {
    private let authRepository: AuthRepository

    private let userSubject = BehaviorSubject<User?>(value: nil)
    private let disposeBag = DisposeBag()

    init(_ authService: AuthRepository) {
        self.authRepository = authService

        self.getUser { _ in }
    }

    func getUser(_ callback: @escaping (User?) -> Void) {
        authRepository.getUser { [weak self] user in
            self?.userSubject.onNext(user)
            callback(user)
        }
    }

    func login(_ callback: @escaping (User?) -> Void) {
        authRepository.login { [weak self] user in
            self?.userSubject.onNext(user)
            callback(user)
        }
    }

    func signUp(_ callback: @escaping (User?) -> Void) {
        authRepository.signUp { [weak self] user in
            self?.userSubject.onNext(user)
            callback(user)
        }
    }

    func logout(_ callback: @escaping (User?) -> Void) {
        authRepository.logout { [weak self] user in
            self?.userSubject.onNext(user)
            callback(user)
        }
    }

    func onAuthStateChanged(_ callback: @escaping (User?) -> Void) {
        userSubject
            .observe(on: MainScheduler.instance)
            .subscribe { (user: User?) in callback(user) }
            .disposed(by: disposeBag)
    }
}
