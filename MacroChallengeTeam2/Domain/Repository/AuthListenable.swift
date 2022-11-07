//
//  AuthListenable.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation

protocol AuthListenable {
    func onAuthStateChanged(_ callback: @escaping (User?) -> Void)
}
