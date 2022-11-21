//
//  AuthRepository.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 03/11/22.
//

import Foundation
import RxSwift

protocol AuthService {
    var user: Observable<User?> { get }

    func fetchUser()
    func signUp()
    func login()
    func logout()
}
