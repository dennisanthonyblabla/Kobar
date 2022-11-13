//
//  RxSwiftListenableAuthWrapper.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift

final class RxSwiftAuthAdapter: AuthService {
    private let authUserSubject = BehaviorSubject<AuthUser?>(value: nil)
    private let userSubject = PublishSubject<User?>()

    private let dataSource: Auth0DataSource
    private let socketService: SocketIODataSource
    
    var user: Observable<User?> {
        userSubject.asObservable()
    }
    
    init(_ dataSource: Auth0DataSource, _ socketService: SocketIODataSource) {
        self.dataSource = dataSource
        self.socketService = socketService

        dataSource.getUser { [weak self] authUser in
            self?.authUserSubject.onNext(authUser)
            
            guard let authUser = authUser else { return }
            
            socketService.onIdExchanged = { user in
                self?.userSubject.onNext(user)
            }
            
            socketService.onConnect = {
                self?.socketService.emitExchangeIdEvent(
                    data: ExchangeIdDto(auth0Id: authUser.id))
            }
            
            socketService.connect(token: authUser.bearerToken)
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
