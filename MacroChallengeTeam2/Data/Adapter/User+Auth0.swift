//
//  Auth0UserAdapter.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import Auth0
import JWTDecode

extension AuthUser {
    init(from credentials: Credentials) {
        id = credentials.idToken
        bearerToken = credentials.accessToken
    }
}
