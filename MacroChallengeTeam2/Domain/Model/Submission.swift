//
//  Submission.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct RunCodeSubmission: Codable {
    let code: String
    let input: String
}

struct SubmitCodeSubmission: Codable {
    let code: String
}
