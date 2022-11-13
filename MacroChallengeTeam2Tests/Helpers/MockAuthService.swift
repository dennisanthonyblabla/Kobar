//
//  MockAuthService.swift
//  MacroChallengeTeam2Tests
//
//  Created by Mohammad Alfarisi on 13/11/22.
//

import RxSwift
@testable import MacroChallengeTeam2

class MockAuthService: AuthService {
    let mockUser: Observable<User?>
    
    init(mockUser: Observable<User?> = .empty()) {
        self.mockUser = mockUser
    }
    
    var user: Observable<User?> {
        mockUser
    }
    
    func signUp() {}
    
    func login() {}
    
    func logout() {}
}
