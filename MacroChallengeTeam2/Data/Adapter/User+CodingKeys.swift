//
//  User+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import Foundation

extension User {
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case name = "nickname"
        case picture = "picture"
        case rating = "rating"
    }
}
