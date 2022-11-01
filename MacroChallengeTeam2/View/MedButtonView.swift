//
//  MedButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 26/10/22.
//

import Foundation
import UIKit
import SnapKit

final class MedbuttonView: UIButton {

    enum Variants {
        case variant1
        case variant2
        case variant3
        case mainPage
    }

    private var variant: Variants?
    private var title: String?

    private lazy var frontBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 29.5
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var backBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 29.5
        view.isUserInteractionEnabled = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(variant: Variants, title: String) {
        super.init(frame: .zero)
        self.title = title
        self.variant = variant
        addSubview(backBG)
        addSubview(frontBG)
        setVariants()
        if variant == .mainPage {
            setupAutoLayoutMP()
        } else {
            setupAutoLayout()
        }

    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    private func setVariants() {
        self.configuration = .none
        setTitle(title, for: .normal)
        setTitle("Touched", for: .highlighted)
        titleLabel?.font = .semi17
        switch variant {
        case .variant1:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            self.setTitleColor(.white, for: .normal)
        case .variant2:
            self.frontBG.backgroundColor = .white
            self.backBG.backgroundColor = .white
            self.backBG.alpha = 0.7
            self.setTitleColor(.kobarBlueActive, for: .normal)
        case .variant3:
            self.frontBG.backgroundColor = .kobarGray
            self.backBG.backgroundColor = .kobarDarkGray
            self.setTitleColor(.kobarDarkGrayText, for: .normal)
        case .mainPage:
            self.frontBG.backgroundColor = .white
            self.backBG.backgroundColor = .white
            self.backBG.alpha = 0.7
            self.setTitleColor(.kobarBlueActive, for: .normal)
            self.frontBG.layer.cornerRadius = 29.5
            self.backBG.layer.cornerRadius = 29.5
        case .none:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            self.setTitleColor(.white, for: .normal)
        }
    }

    private func setupAutoLayout() {
        backBG.snp.makeConstraints { (make) in
            make.height.width.equalTo(frontBG)
            make.centerX.equalTo(frontBG)
            make.centerY.equalTo(frontBG).offset(5)
        }

        frontBG.snp.makeConstraints { (make) in
            make.height.equalTo(59)
            make.width.equalToSuperview().offset(64)
            make.center.equalToSuperview()
        }
    }

    private func setupAutoLayoutMP() {
        backBG.snp.makeConstraints { (make) in
            make.height.width.equalTo(frontBG)
            make.centerX.equalTo(frontBG)
            make.centerY.equalTo(frontBG).offset(5)
        }

        frontBG.snp.makeConstraints { (make) in
            make.height.equalTo(59)
            make.width.equalTo(245)
            make.center.equalToSuperview()
        }
    }
}
