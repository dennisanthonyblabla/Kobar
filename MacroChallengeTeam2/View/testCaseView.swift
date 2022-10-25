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
        view.addSubview(testCaseSymbol)
        view.addSubview(testCaselabel)
        view.addSubview(testCaseLevel)
        return view
    }()

    private lazy var testCaseSymbol: UIImageView = {
        let image = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
        let profile = UIImage(systemName: "checkmark", withConfiguration: config)
        image.image = profile?.withTintColor(.white, renderingMode: .alwaysOriginal)
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

    private lazy var testCaseLevel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .left
        label.textColor = .white
        label.font = .semi22
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init() {
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
        testCaseLevel.snp.makeConstraints { (make) in
            make.width.equalTo(testCaseLevel.snp.width)
            make.height.equalTo(testCaseLevel.snp.height)
            make.leading.equalTo(testCaselabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
    }
}
