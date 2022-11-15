//
//  NavigationSpy.swift
//  MacroChallengeTeam2Tests
//
//  Created by Mohammad Alfarisi on 14/11/22.
//

import UIKit

class NavigationSpy: UINavigationController {
    var pages: [UIViewController] = []
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        pages = viewControllers
    }
    
    func page(at index: Int) -> UIViewController {
        pages[index]
    }
}
