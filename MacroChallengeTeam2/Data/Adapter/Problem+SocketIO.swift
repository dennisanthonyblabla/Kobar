//
//  Problem+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

class ProblemWrapper: Decodable {
    let problem: Problem?
    
    func toProblem() -> Problem? { problem }
}
