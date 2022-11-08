//
//  SocketParser.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 08/11/22.
//

import Foundation

class SocketParser {

    static func convert<T: Decodable>(data: Any) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        let decoder = JSONDecoder()
        do{
           let  _ = try decoder.decode(T.self, from: jsonData)
            
        }catch{
            print("CheckError \(error)")
        }
        return try decoder.decode(T.self, from: jsonData)
    }

}
