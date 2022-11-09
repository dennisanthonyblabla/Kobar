//
//  AuthRepository.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 03/11/22.
//

import Foundation

protocol AuthService {
    func getUser(_ callback: @escaping (AuthUser?) -> Void)
    func signUp(_ callback: @escaping (AuthUser?) -> Void)
    func login(_ callback: @escaping (AuthUser?) -> Void)
    func logout(_ callback: @escaping (AuthUser?) -> Void)
}
