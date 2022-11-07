//
//  AuthRepository.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 03/11/22.
//

import Foundation

protocol AuthRepository {
    func getUser(_ callback: @escaping (User?) -> Void)
    func signUp(_ callback: @escaping (User?) -> Void)
    func login(_ callback: @escaping (User?) -> Void)
    func logout(_ callback: @escaping (User?) -> Void)
}
