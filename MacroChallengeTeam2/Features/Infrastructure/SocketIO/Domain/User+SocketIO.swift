//
//  User+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

struct UserWrapper: Decodable {
    let user: User
    
    func toUser() -> User { user }
}
