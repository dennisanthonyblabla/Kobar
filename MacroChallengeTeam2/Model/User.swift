//
//  User.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    let imageUrl: String
    let rating: Int
    let bearerToken: String
}
