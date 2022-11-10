//
//  SubmitResponse.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct SubmitCodeResult: Codable {
    let tests: [SubmitTestResult]
    
    static func empty() -> SubmitCodeResult {
        SubmitCodeResult(tests: [])
    }
}

struct SubmitTestResult: Codable {
    let output: String
    let outputType: OutputType
    let testCase: SubmitTestCase
}

struct SubmitTestCase: Codable {
    let input: String
    let output: String
}
