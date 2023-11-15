//
//  AuthDataSource.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation
import RxSwift
import RxRelay

final class AuthDataSource: AuthService {
    private let authUserSubject = PublishRelay<AuthUser?>()
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
    
    func fetchUser() {
        dataSource.getUser { [weak self] user in
            self?.authUserSubject.accept(user)
        }
    }
    
    func deleteAccount() {
        dataSource.getUser { [weak self] user in
            guard let user = user else {
                return
            }
            
            guard let url = URL(string: "http://kobar.up.railway.app/user") else {
                return
            }
            var request = URLRequest(
                url: url,
                cachePolicy: .reloadIgnoringLocalCacheData
            )
            request.httpMethod = "DELETE"
            request.addValue("Bearer \(user.bearerToken)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, _ in
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    return
                }
                
                self?.authUserSubject.accept(nil)
            }
            
            task.resume()
        }
    }
    
    func login() {
        dataSource.login { [weak self] user in
            self?.authUserSubject.accept(user)
        }
    }
    
    func signUp() {
        dataSource.signUp { [weak self] user in
            self?.authUserSubject.accept(user)
        }
    }
    
    func logout() {
        dataSource.logout { [weak self] _ in
            self?.authUserSubject.accept(nil)
        }
    }
}
