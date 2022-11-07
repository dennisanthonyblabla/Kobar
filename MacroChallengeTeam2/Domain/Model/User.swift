//
//  User.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let imageURL: String
    let rating: Int
    let bearerToken: String
}
