//
//  AuthenticationCoordinatorTests.swift
//  MacroChallengeTeam2Tests
//
//  Created by Mohammad Alfarisi on 12/11/22.
//

import XCTest
@testable import MacroChallengeTeam2

final class AuthCoordinatorTests: XCTestCase {
    func test_InitialState() {
        let (_, navigationController) = makeSUT()
        
        XCTAssertTrue(navigationController.viewControllers.isEmpty)
    }
    
    private func makeSUT() -> (AuthCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(
            navigationController,
            authService: MockAuthService(),
            socketService: SocketIODataSource(url: URL(string: "http://www.google.com")))
        
        return (sut, navigationController)
    }
}

private class MockAuthService: AuthService {
    func getUser(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
    
    func signUp(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
    
    func login(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
    
    func logout(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
}
