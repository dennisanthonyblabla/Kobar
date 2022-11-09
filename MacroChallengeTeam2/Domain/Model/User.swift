//
//  User.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let picture: String
    let rating: Double
}
