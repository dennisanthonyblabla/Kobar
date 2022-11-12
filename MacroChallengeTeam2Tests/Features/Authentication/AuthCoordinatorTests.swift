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
        let sut = makeSUT()
        
        XCTAssertTrue(sut.pages.isEmpty)
    }
    
    func test_start_ShouldPushLoadingPage() {
        let sut = makeSUT()
        
        sut.start()
        
        XCTAssertEqual(sut.pages.count, 1)
        XCTAssertTrue(sut.page(at: 0) is LoadingPageViewController)
    }
    
    func test_start_ShouldPushSignInPage_WhenServiceReturnsNil() {
        let sut = makeSUT()
        
        sut.start()
        
        let exp = expectation(description: "wait for viewModel")
        exp.isInverted = true
        wait(for: [exp], timeout: 2)
        
        XCTAssertEqual(sut.pages.count, 2)
        XCTAssertTrue(sut.page(at: 1) is SignInPageViewController)
    }
    
    private func makeSUT() -> AuthCoordinator {
        let navigationController = UINavigationController()
        let sut = AuthCoordinator(
            navigationController,
            authService: MockAuthService(),
            socketService: SocketIODataSource(url: URL(string: "http://www.google.com")))
        
        return sut
    }
}

private extension AuthCoordinator {
    var pages: [UIViewController] {
        navigationController.viewControllers
    }
    
    func page(at index: Int) -> UIViewController {
        pages[index]
    }
}

private class MockAuthService: AuthService {
    func getUser(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {
        callback(nil)
    }
    
    func signUp(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
    
    func login(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
    
    func logout(_ callback: @escaping (MacroChallengeTeam2.AuthUser?) -> Void) {}
}
