//
//  testCaseView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 24/10/22.
//

import Foundation
import UIKit
import SnapKit

final class TestCaseButton: UIButton {
    enum Status {
        case correct
        case wrong
    }
    
    enum Style {
        case fill
        case transparent
    }

    var style: Style?{
        didSet {
            testCaseStyle()
            testCaseStatus()
        }
    }
    private var status: Status?
    private var order: Int?
    
    private lazy var testCaseBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarBlueActive
        view.layer.cornerRadius = 29
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var testCaseSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    private lazy var testCaseOrder: UILabel = {
        let label = UILabel()
        label.text = String(order ?? 0)
        label.textAlignment = .left
        label.textColor = .white
        label.font = .semi22
        label.isUserInteractionEnabled = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(style: Style? = .transparent, status: Status, order: Int) {
        super.init(frame: .zero)
        self.style = style
        self.status = status
        self.order = order
        addSubview(testCaseBG)
        addSubview(testCaseSymbol)
        addSubview(testCaseOrder)
        testCaseStyle()
        testCaseStatus()
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
            break
        }
    }
    
    private func testCaseStatus() {
        self.configuration = .none
        setTitle("Test Case", for: .normal)
        self.setTitleColor(.white, for: .normal)
        titleLabel?.font = .semi22
        switch status {
        case .correct:
            let image = UIImage(
                systemName: "checkmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
            )
            if style == .fill {
                testCaseSymbol.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
                testCaseOrder.textColor = .white
            } else {
                testCaseSymbol.image = image?.withTintColor(.kobarGreen, renderingMode: .alwaysOriginal)
                testCaseOrder.textColor = .kobarGreen
                self.setTitleColor(.kobarGreen, for: .normal)
            }
        case .wrong:
            let image = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
            )
            if style == .fill {
                testCaseSymbol.image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
                testCaseOrder.textColor = .white
            } else {
                testCaseSymbol.image = image?.withTintColor(.kobarRed, renderingMode: .alwaysOriginal)
                testCaseOrder.textColor = .kobarRed
                self.setTitleColor(.kobarRed, for: .normal)
            }
        case .none:
            break
        }
    }
    
    private func setupAutoLayout() {
        testCaseBG.snp.makeConstraints { make in
            make.width.equalTo(210)
            make.height.equalTo(58)
            make.centerX.equalToSuperview().offset(-4)
            make.centerY.equalToSuperview()
        }
        
        testCaseSymbol.snp.makeConstraints { make in
            make.width.equalTo(testCaseSymbol.snp.width)
            make.height.equalTo(testCaseSymbol.snp.height)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(-35)
        }
        
        testCaseOrder.snp.makeConstraints { make in
            make.width.equalTo(testCaseOrder.snp.width)
            make.height.equalTo(testCaseOrder.snp.height)
            make.trailing.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
    }
}
