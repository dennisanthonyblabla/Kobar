//
//  AuthListenable.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation

/// Auth repository that calls onAuthStateChanged instead of using callbacks
/// from signUp, login, and logout
protocol AuthRepositoryListenableAdapter {
    func onAuthStateChanged(_ callback: @escaping (User?) -> Void)
    func signUp()
    func login()
    func logout()
}
