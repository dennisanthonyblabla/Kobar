//
//  RxSwiftListenableAuthWrapper.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift

// TODO: @salman maybe there's a better way to do this
final class RxSwiftAuthRepositoryAdapter: AuthRepositoryListenableAdapter {
    private let authRepository: AuthRepository

    private let userSubject = BehaviorSubject<User?>(value: nil)
    private let disposeBag = DisposeBag()

    init(_ authService: AuthRepository) {
        self.authRepository = authService
        getUser()
    }

    private func getUser() {
        authRepository.getUser { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func login() {
        authRepository.login { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func signUp() {
        authRepository.signUp { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func logout() {
        authRepository.logout { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func onAuthStateChanged(_ callback: @escaping (User?) -> Void) {
        userSubject
            .observe(on: MainScheduler.instance)
            .subscribe { (user: User?) in callback(user) }
            .disposed(by: disposeBag)
    }
}
