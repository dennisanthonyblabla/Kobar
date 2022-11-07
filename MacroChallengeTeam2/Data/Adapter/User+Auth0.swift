//
//  Auth0UserAdapter.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import Auth0
import JWTDecode

extension User {
    init?(from credentials: Credentials) {
        guard let jwt = try? decode(jwt: credentials.idToken) else { return nil }

        id = UUID(uuidString: credentials.idToken) ?? UUID()
        name = jwt["name"].string ?? ""
        imageURL = jwt["picture"].string ?? ""
        rating = jwt["rating"].integer ?? 0
        bearerToken = credentials.accessToken
    }
}
