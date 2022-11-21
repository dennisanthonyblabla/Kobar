//
//  Coordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import Foundation

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var completion: (() -> Void)? { get set }
    func start()
}

extension Coordinator {
    func store(_ coorindator: Coordinator) {
        childCoordinators.append(coorindator)
    }
    
    func free(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
