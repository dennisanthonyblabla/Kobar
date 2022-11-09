//
//  NSAttributedString+withLineSpacing.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}
