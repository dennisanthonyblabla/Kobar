//
//  SubmitResponse.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct SubmitCodeResult: Equatable, Decodable {
    let code: String
    let tests: [SubmitTestResult]
    
    static func empty() -> SubmitCodeResult {
        SubmitCodeResult(code: "", tests: [])
    }
}

struct SubmitTestResult: Equatable, Decodable {
    let output: String
    let outputType: OutputType
    let testCase: SubmitTestCase
}

struct SubmitTestCase: Equatable, Decodable {
    let input: String
    let output: String
}
