//
//  User.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let nickname: String
    let picture: String
    let rating: Int
    
    static func empty() -> User {
        User(id: "", nickname: "", picture: "", rating: 0)
    }
}
