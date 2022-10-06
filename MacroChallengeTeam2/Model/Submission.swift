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
    // let type: RunResponse & SubmitResponse -> yang ini gua belom tahu gimana caranya bisa 2 protocol sekaligus
}
