//
//  Auth0Repository.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 03/11/22.
//

import Foundation
import Auth0

class Auth0DataSource {
    static let shared = Auth0DataSource()
    private let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    private init() {}

    // TODO: @salman make thread-safe
    private func storeCredentials(_ credentials: Credentials) {
        _ = credentialsManager.store(credentials: credentials)
    }

    private func clearCredentials() {
        _ = credentialsManager.clear()
    }

    private func hasValidCredentials() -> Bool {
        credentialsManager.hasValid()
    }

    func getUser(_ callback: @escaping (AuthUser?) -> Void) {
        guard hasValidCredentials() else {
            callback(nil)
            return
        }

        credentialsManager.credentials { result in
            switch result {
            case .success(let credentials):
                callback(AuthUser(from: credentials))
            case .failure:
                callback(nil)
            }
        }
    }

    func signUp(_ callback: @escaping (AuthUser?) -> Void) {
        startWebAuth(parameters: ["screen_hint": "signup"], callback: callback)
    }

    func login(_ callback: @escaping (AuthUser?) -> Void) {
        startWebAuth(callback: callback)
    }

    func logout(_ callback: @escaping () -> Void) {
        guard let redirectURL = URL(
            string: "com.namanya-apa.MacroChallengeTeam2://kobar.au.auth0.com/ios/com.namanya-apa.MacroChallengeTeam2/logout")
        else { return }

        Auth0
            .webAuth()
            .redirectURL(redirectURL)
            .clearSession { _ in
                callback()
            }

        clearCredentials()

        return
    }

    private func startWebAuth(
        parameters: [String: String] = [:],
        callback: @escaping (AuthUser?) -> Void)
    {
        Auth0
            .webAuth()
            .parameters(parameters)
            .audience("kobar-api")
            .start { [weak self] result in
                switch result {
                case .success(let credentials):
                    self?.storeCredentials(credentials)
                    callback(AuthUser(from: credentials))
                case .failure:
                    callback(nil)
                }
            }
    }
}
