//
//  TestCase.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation
struct TestCase: Identifiable, Codable {
    let id: UUID
    let input: String
    let output: String
}
