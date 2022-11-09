//
//  User+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import Foundation

extension User {
    init(dict: [String: AnyObject]) throws {
        id = dict["userId"] as? String ?? ""
        name = dict["nickname"] as? String ?? ""
        picture = dict["picture"] as? String ?? ""
        rating = dict["rating"] as? Double ?? 0
    }
}
