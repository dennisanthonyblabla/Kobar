//
//  TestCase.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation
struct TestCase: Identifiable, Codable {
    let id: String
    let input: String
    let output: String
    let order: Int
}
