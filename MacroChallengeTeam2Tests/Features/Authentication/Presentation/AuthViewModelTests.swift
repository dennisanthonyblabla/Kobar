//
//  AuthViewModelTests.swift
//  MacroChallengeTeam2Tests
//
//  Created by Mohammad Alfarisi on 13/11/22.
//

import XCTest
import RxSwift
@testable import Kobar

final class AuthViewModelTests: XCTestCase {
    func test_initialState_ShouldBeLoading() {
        let service = MockAuthService()
        let sut = AuthViewModel(service: service)
        let spy = StateSpy(sut.state)
        
        XCTAssertEqual(spy.values, [.loading])
    }
    
    func test_state_ShouldBeUnauthenticated_WhenServiceUserIsNil() {
        let service = MockAuthService(mockUser: .just(nil))
        let sut = AuthViewModel(service: service)
        let spy = StateSpy(sut.state)
        
        XCTAssertEqual(
            spy.values,
            [.loading, .unauthenticated])
    }
    
    func test_state_ShouldBeAuthenticated_WhenServiceReturnsUser() {
        let user = User(id: "id 0", nickname: "nickname 0", picture: "picture 0", rating: 1000)
        let service = MockAuthService(mockUser: .just(user))
        let sut = AuthViewModel(service: service)
        let spy = StateSpy(sut.state)
        
        XCTAssertEqual(
            spy.values,
            [.loading, .authenticated(user)])
    }
}
