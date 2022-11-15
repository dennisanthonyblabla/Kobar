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
    
    func getUserState() -> Observable<State> {
        let observable: Observable<State> = Observable.merge(
            .just(.loading),
            service.user
                .map { user in
                    guard let user = user else { return .unauthenticated }
                    return .authenticated(user)
                }
        )
        
        service.fetchUser()
        
        return observable
    }
}
