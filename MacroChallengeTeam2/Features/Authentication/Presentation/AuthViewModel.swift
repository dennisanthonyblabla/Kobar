//
//  AuthViewModel.swift
//  MacroChallengeTeam2
//
//  Created by Mohammad Alfarisi on 13/11/22.
//

import RxSwift

struct AuthViewModel {
    enum State: Equatable {
        case loading
        case unauthenticated
        case authenticated(User)
    }
    
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
    }
    
    var state: Observable<State> {
        Observable.merge(
            mapUserToState(),
            .just(.loading)
        )
    }
    
    private func mapUserToState() -> Observable<State> {
        service.user
            .map { user in
                guard let user = user else { return .unauthenticated }
                return .authenticated(user)
            }
    }
}
