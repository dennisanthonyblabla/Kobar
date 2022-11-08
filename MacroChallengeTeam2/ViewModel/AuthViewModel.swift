//
//  RxSwiftListenableAuthWrapper.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift

final class AuthViewModel {
    private let authRepository: AuthRepository

    let userSubject = BehaviorSubject<User?>(value: nil)

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
}
