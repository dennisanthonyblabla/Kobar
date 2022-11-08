//
//  BaseCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 08/11/22.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> Void)?
    
    func start() {
        fatalError("Children should implement `start`.")
    }
    
    func store(_ coorindator: Coordinator) {
        childCoordinators.append(coorindator)
    }
    
    func free(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
