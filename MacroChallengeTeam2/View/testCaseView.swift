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

    enum Status {
        case correct
        case wrong
    }

    var order: String?

    private lazy var testCaseBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarBlueActive
        view.layer.cornerRadius = 29
//        view.addSubview(testCaseSymbol)
//        view.addSubview(testCaseLevel)
        return view
    }()

    private lazy var testCaseLevel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .semi22
        return label
    }()

    private lazy var testCaseSymbol: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .bold22
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(status: Status) {
        super.init(frame: .zero)
        addSubview(testCaseBG)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {
        testCaseBG.snp.makeConstraints { (make) in
            make.width.equalTo(206)
            make.height.equalTo(58)
            make.center.equalToSuperview()
        }
    }
}
