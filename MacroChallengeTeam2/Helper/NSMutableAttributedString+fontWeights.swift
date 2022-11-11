//
//  NSMutableAttributedString+fontWeights.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func appendWithFont(_ value: String, font: UIFont?) -> NSMutableAttributedString {
        guard let font = font else { return self }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
