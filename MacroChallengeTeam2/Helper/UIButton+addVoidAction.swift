//
//  UIButton+addVoidAction.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import UIKit

extension UIButton {
    func addVoidAction(_ action: (() -> Void)?, for event: UIControl.Event) {
        self.addAction(
            UIAction { _ in
                action?()
            }, for: event)
    }
}
