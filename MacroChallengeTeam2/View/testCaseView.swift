//
//  testCaseView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 24/10/22.
//

import Foundation
import UIKit
import SnapKit

final class TestCaseButton: UIView {

    private lazy var testCaseBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarBlueActive
        view.layer.cornerRadius = 29
        return view
    }()

    private lazy var testCaseLevel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
//        label.font =
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {

    }
}
