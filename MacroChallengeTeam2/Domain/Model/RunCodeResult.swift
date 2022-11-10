//
//  RunResponse.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 06/10/22.
//

import Foundation

struct RunCodeResult: Codable {
    let output: String
    let type: OutputType
    
    enum OutputType: Codable {
        case correct, incorrect, error
    }
}
