//
//  AuthDataSource.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift

final class AuthDataSource: AuthService {
    private let authUserSubject = PublishSubject<AuthUser?>()
    private let dataSource: Auth0DataSource
    private let socketService: SocketIODataSource
    
    var user: Observable<User?> {
        authUserSubject.flatMap(exchangeId)
    }
    
    init(_ dataSource: Auth0DataSource, _ socketService: SocketIODataSource) {
        self.dataSource = dataSource
        self.socketService = socketService
    }
    
    private func exchangeId(_ authUser: AuthUser?) -> Observable<User?> {
        guard let authUser = authUser else { return .just(nil) }
        
        return Observable.create { [weak self] observer in
            self?.socketService.onIdExchanged = { user in
                observer.onNext(user)
            }
            
            self?.socketService.onConnect = {
                self?.socketService.emitExchangeIdEvent(
                    data: ExchangeIdDto(auth0Id: authUser.id))
            }
            
            self?.socketService.connect(token: authUser.bearerToken)
            
            return Disposables.create {}
        }
    }
    
    func getUser() {
        dataSource.getUser { [weak self] user in
            self?.authUserSubject.onNext(user)
        }
    }
    
    func login() {
        dataSource.login { [weak self] user in
            self?.authUserSubject.onNext(user)
        }
    }
    
    func signUp() {
        dataSource.signUp { [weak self] user in
            self?.authUserSubject.onNext(user)
        }
    }
    
    func logout() {
        dataSource.logout { [weak self] in
            self?.authUserSubject.onNext(nil)
        }
    }
}
