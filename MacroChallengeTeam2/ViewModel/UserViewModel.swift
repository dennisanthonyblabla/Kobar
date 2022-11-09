//
//  UserViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

class UserViewModel {
    let userSubject = BehaviorSubject<User?>(value: nil)
    
    private let socketHandler: SocketIODataSource
    
    init(socketHandler: SocketIODataSource) {
        self.socketHandler = socketHandler
    }
    
    func connect(with authUser: AuthUser) {
        socketHandler.onConnect = { [weak self] in
            self?.socketHandler.emitExchangeIdEvent(
                data: ExchangeIdDto(auth0Id: authUser.id))
        }
        
        socketHandler.onIdExchanged = { [weak self] user in
            self?.userSubject.onNext(user)
        }
        
        socketHandler.connect(token: authUser.bearerToken)
    }
}
