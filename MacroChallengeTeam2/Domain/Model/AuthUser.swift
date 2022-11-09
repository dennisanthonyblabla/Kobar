//
//  User.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct AuthUser: Identifiable, Codable {
    let id: String
    let bearerToken: String
}
