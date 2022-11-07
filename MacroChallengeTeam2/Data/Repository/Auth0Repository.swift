//
//  Auth0Repository.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 03/11/22.
//

import Foundation
import Auth0

class Auth0Repository: AuthService {
    static let shared = Auth0Repository()
    private let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    private init() {}

    // TODO: make thread-safe
    private func storeCredentials(_ credentials: Credentials) {
        let didStore = credentialsManager.store(credentials: credentials)
    }

    private func clearCredentials() {
        let didClear = credentialsManager.clear()
    }

    func getUser(_ callback: @escaping (User?) -> Void) {
        guard credentialsManager.hasValid() else {
            callback(nil)
            return
        }

        credentialsManager.credentials { result in
            switch result {
            case .success(let credentials):
                callback(User(from: credentials))
            case .failure:
                callback(nil)
            }
        }
    }

    func login(_ callback: @escaping (User?) -> Void) {
        Auth0
            .webAuth()
//            .parameters(["screen_hint": "signup"])
            .audience("kobar-api")
            .start { [weak self] result in
                switch result {
                case .success(let credentials):
                    self?.storeCredentials(credentials)
                    callback(User(from: credentials))
                case .failure(let error):
                    print(error)
                }
            }
    }

    func logout(_ callback: @escaping (User?) -> Void) {
        guard let redirectURL = URL(
            string: "com.namanya-apa.MacroChallengeTeam2://kobar.au.auth0.com/ios/com.namanya-apa.MacroChallengeTeam2/logout")
        else { return }

        Auth0
            .webAuth()
            .redirectURL(redirectURL)
            .clearSession { result in
                print(result)
                switch result {
                case .success:
                    callback(nil)
                case .failure(let error):
                    print(error)
                }
            }

        clearCredentials()

        return
    }
}
