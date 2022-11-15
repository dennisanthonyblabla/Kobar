//
//  AuthenticationCoordinatorTests.swift
//  MacroChallengeTeam2Tests
//
//  Created by Mohammad Alfarisi on 12/11/22.
//

import XCTest
import RxSwift
@testable import MacroChallengeTeam2

final class AuthCoordinatorTests: XCTestCase {
    func test_InitialState() {
        let (_, spy) = makeSUT()
        
        XCTAssertTrue(spy.pages.isEmpty)
    }
    
    func test_start_ShouldPushLoadingPage() {
        let (sut, spy) = makeSUT()
        
        sut.start()
        
        XCTAssertEqual(spy.pages.count, 1)
        XCTAssertTrue(spy.page(at: 0) is LoadingPageViewController)
    }
    
    func test_start_ShouldPushSignInPage_WhenServiceReturnsNil() {
        let service = MockAuthService(mockUser: .just(nil))
        let (sut, spy) = makeSUT(authService: service)
        
        sut.start()
        
        XCTAssertEqual(spy.pages.count, 1)
        XCTAssertTrue(spy.page(at: 0) is SignInPageViewController)
    }
    
    func test_start_ShouldPushMainPage_WhenServiceReturnsUser() {
        let user = User(id: "id 0", nickname: "nickname 0", picture: "picture 0", rating: 1000)
        let service = MockAuthService(mockUser: .just(user))
        let (sut, spy) = makeSUT(authService: service)
        
        sut.start()
        
        XCTAssertEqual(spy.pages.count, 1)
        XCTAssertTrue(spy.page(at: 0) is MainPageViewController)
    }
    
    private func makeSUT(authService: AuthService = MockAuthService()) -> (AuthCoordinator, NavigationSpy) {
        let viewModel = AuthViewModel(service: authService)
        let spy = NavigationSpy()
        let sut = AuthCoordinator(
            spy,
            viewModel: viewModel,
            makeLoading: { LoadingPageViewController() },
            makeSignIn: { SignInPageViewController() },
            makeMain: { _, _ in MainPageViewController() })
        
        return (sut, spy)
    }
}
