//
//  BaseCoordinator.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 08/11/22.
//

import Foundation

class BaseCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var completion: (() -> Void)?
    
    init() {
        print("Init Coordinator: \(type(of: self))")
    }
    
    deinit {
        print("Deinit Coordinator: \(type(of: self))")
    }
    
    func start() {}
    
    func startNextCoordinator(_ coordinator: Coordinator) {
        store(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func startAndReplaceNextCoordinator(_ coordinator: Coordinator) {
        finishCoordinator()
        
        guard let parentCoordinator = parentCoordinator else { return }
        
        parentCoordinator.store(coordinator)
        coordinator.parentCoordinator = parentCoordinator
        coordinator.start()
    }
    
    func finishCoordinator() {
        parentCoordinator?.free(self)
        completion?()
    }
}
