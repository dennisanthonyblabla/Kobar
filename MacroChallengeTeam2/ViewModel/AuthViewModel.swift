//
//  RxSwiftListenableAuthWrapper.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift

final class AuthViewModel {
    let userSubject = BehaviorSubject<AuthUser?>(value: nil)
    
    private let authService: AuthService

    init(_ authService: AuthService) {
        self.authService = authService
        getUser()
    }

    private func getUser() {
        authService.getUser { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func login() {
        authService.login { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func signUp() {
        authService.signUp { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }

    func logout() {
        authService.logout { [weak self] user in
            self?.userSubject.onNext(user)
        }
    }
}
