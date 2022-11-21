//
//  SubmitCodeResult.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct SubmitCodeResult: Equatable, Decodable {
    let code: String
    let tests: [SubmitCodeResultTest]
    let problem: SubmitCodeResultProblem
    
    static func empty() -> SubmitCodeResult {
        SubmitCodeResult(code: "", tests: [], problem: SubmitCodeResultProblem(reviewVideoURL: "", reviewText: ""))
    }
}

struct SubmitCodeResultProblem: Equatable, Decodable {
    let reviewVideoURL: String
    let reviewText: String
}

struct SubmitCodeResultTest: Equatable, Decodable {
    let output: String
    let outputType: OutputType
    let testCase: SubmitCodeResultTestCase
}

struct SubmitCodeResultTestCase: Equatable, Decodable {
    let input: String
    let output: String
}
