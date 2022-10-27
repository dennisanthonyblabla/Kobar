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

    enum Style {
        case fill
        case transparent
    }

    private var status: Status?
    private var style: Style?
    private var order: Int?

    private lazy var testCaseBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarBlueActive
        view.layer.cornerRadius = 29
        return view
    }()

    private lazy var testCaseSymbol: UIImageView = {
        let image = UIImageView()
        return image
    }()

    private lazy var testCaselabel: UILabel = {
        let label = UILabel()
        label.text = "Test Case"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .semi22
        return label
    }()

    private lazy var testCaseOrder: UILabel = {
        let label = UILabel()
        label.text = String(order ?? 0)
        label.textAlignment = .left
        label.textColor = .white
        label.font = .semi22
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(style: Style, status: Status, order: Int) {
        super.init(frame: .zero)
        self.style = style
        self.status = status
        self.order = order
        testCaseStyle()
        testCaseStatus()
        addSubview(testCaseBG)
        addSubview(testCaseSymbol)
        addSubview(testCaselabel)
        addSubview(testCaseOrder)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    private func testCaseStyle() {
        switch style {
        case .fill:
            testCaseBG.alpha = 1
        case .transparent:
            testCaseBG.alpha = 0
        case .none:
            testCaseBG.alpha = 1

        }
    }

    private func testCaseStatus() {

        switch status {
        case .correct:
            let image = UIImage(
                systemName: "checkmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
            )
            if style == .fill {
                testCaseSymbol.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
            } else if style == .transparent {
                testCaseSymbol.image = image?.withTintColor(.kobarGreen, renderingMode: .alwaysOriginal)
                testCaseOrder.textColor = .kobarGreen
                testCaselabel.textColor = .kobarGreen
            }
        case .wrong:
            let image = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
            )
            if style == .fill {
                testCaseSymbol.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
            } else {
                testCaseSymbol.image = image?.withTintColor(.kobarRed, renderingMode: .alwaysOriginal)
                testCaseOrder.textColor = .kobarRed
                testCaselabel.textColor = .kobarRed

            }
        case .none:
            testCaseSymbol.image = UIImage(
                systemName: "checkmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
            )?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }

    private func setupAutoLayout() {

        testCaseBG.snp.makeConstraints { (make) in
            make.width.equalTo(206)
            make.height.equalTo(58)
            make.center.equalToSuperview()
        }

        testCaseSymbol.snp.makeConstraints { (make) in
            make.width.equalTo(testCaseSymbol.snp.width)
            make.height.equalTo(testCaseSymbol.snp.height)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(testCaselabel.snp.leading).offset(-10)
        }

        testCaselabel.snp.makeConstraints { (make) in
            make.width.equalTo(testCaselabel.snp.width)
            make.height.equalTo(testCaselabel.snp.height)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(5)
        }

        testCaseOrder.snp.makeConstraints { (make) in
            make.width.equalTo(testCaseOrder.snp.width)
            make.height.equalTo(testCaseOrder.snp.height)
            make.leading.equalTo(testCaselabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}
