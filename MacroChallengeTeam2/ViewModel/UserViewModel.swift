//
//  UserViewModel.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import RxSwift

// TODO: @salman should have some validation to make sure socketHandler is connected on exchangeId and disconnected when done
class UserViewModel {
    private let socketHandler: SocketIODataSource
    
    init(socketHandler: SocketIODataSource) {
        self.socketHandler = socketHandler
    }
    
    func connect(for authUser: AuthUser) -> Completable {
        Completable.create { [weak self] completable in
            self?.socketHandler.onConnect = {
                completable(.completed)
            }
            
            self?.socketHandler.connect(token: authUser.bearerToken)
            
            return Disposables.create {}
        }
    }
    
    func exchangeId(from authUser: AuthUser) -> Single<User> {
        Single<User>.create { [weak self] single in
            self?.socketHandler.onIdExchanged = { user in
                single(.success(user))
            }
            
            self?.socketHandler.emitExchangeIdEvent(
                data: ExchangeIdDto(auth0Id: authUser.id))
            
            return Disposables.create {}
        }
    }
    
    func disconnect() {
        socketHandler.disconnect()
    }
}
