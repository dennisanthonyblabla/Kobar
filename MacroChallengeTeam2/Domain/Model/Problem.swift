//
//  Problem.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct Problem: Identifiable, Codable {
    let id: String
    let prompt: String
    let inputFormat: String
    let outputFormat: String
    let testCases: [TestCase]
    let exampleCount: Int
    let reviewVideoURL: String
    let reviewText: String
}
