//
//  Submission.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct Submission: Identifiable, Codable {
    let id: UUID
    let code: String
    let input: String
    
    enum SubmissionType {
        case run
        case submit
    }
}
