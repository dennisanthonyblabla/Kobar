//
//  Battle+SocketIO.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation

extension Battle {
    static func convert(from data: [Any]) throws -> Battle {
        let dict = data[0] as? [String: Any]
        guard let battleJSON = dict?["battle"] else { throw CustomError.failedParsing }
        return try SocketParser.convert(data: battleJSON)
    }
}
