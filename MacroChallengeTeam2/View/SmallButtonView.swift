//
//  SmallButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 01/11/22.
//

import UIKit
import SnapKit

final class SmallButtonView: UIButton {
    enum BtnType {
        case share
        case normal
    }

    enum Variants {
        case variant1
        case variant2
        case variant3
    }

    private var title: String?
    private var variant: Variants?
    private var btnType: BtnType?

    private lazy var frontBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var backBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var shareIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        let config = UIImage.SymbolConfiguration(pointSize: 17)
        let profile = UIImage(systemName: "paperplane.fill", withConfiguration: config)
        imageView.image = profile?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()

    init(variant: Variants, title: String, btnType: BtnType) {
        super.init(frame: .zero)
        self.title = title
        self.btnType = btnType
        self.variant = variant
        addSubview(backBG)
        addSubview(frontBG)
        addSubview(shareIcon)
        setupButtonType()
        setupVariants()
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {
        if btnType == .normal {
            backBG.snp.makeConstraints { make in
                make.height.width.equalTo(frontBG)
                make.centerX.equalTo(frontBG)
                make.centerY.equalTo(frontBG).offset(5)
            }
            frontBG.snp.makeConstraints { make in
                make.height.equalTo(50)
                make.width.equalTo(149)
                make.center.equalToSuperview()
            }
        } else {
            backBG.snp.makeConstraints { make in
                make.height.width.equalTo(frontBG)
                make.centerX.equalTo(frontBG)
                make.centerY.equalTo(frontBG).offset(5)
            }
            frontBG.snp.makeConstraints { make in
                make.height.equalTo(45)
                make.width.equalTo(149)
                make.trailing.equalToSuperview().offset(35)
                make.centerY.equalToSuperview()
            }
            shareIcon.snp.makeConstraints { make in
                make.width.equalTo(shareIcon)
                make.height.equalTo(shareIcon)
                make.centerY.equalToSuperview()
                make.leading.equalTo(frontBG).offset(35)
            }
        }
    }

    private func setupVariants() {
        self.configuration = .none
        setTitle(title, for: .normal)
        titleLabel?.font = .bold17
        let config = UIImage.SymbolConfiguration(pointSize: 17)
        let profile = UIImage(systemName: "paperplane.fill", withConfiguration: config)
        switch variant {
        case .variant1:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            self.setTitleColor(.white, for: .normal)
            self.shareIcon.image = profile?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .variant2:
            self.frontBG.backgroundColor = .white
            self.backBG.backgroundColor = .white
            self.backBG.alpha = 0.7
            self.setTitleColor(.kobarBlueActive, for: .normal)
            self.shareIcon.image = profile?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal)
        case .variant3:
            self.frontBG.backgroundColor = .kobarGray
            self.backBG.backgroundColor = .kobarDarkGray
            self.setTitleColor(.kobarDarkGrayText, for: .normal)
            self.shareIcon.image = profile?.withTintColor(.kobarDarkGrayText, renderingMode: .alwaysOriginal)
        case .none:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            self.setTitleColor(.white, for: .normal)
            self.shareIcon.image = profile?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }

    private func setupButtonType() {
        switch btnType {
        case .normal:
            self.shareIcon.alpha = 0
        case .share:
            self.shareIcon.alpha = 1
        case .none:
            self.shareIcon.alpha = 0
        }
    }
}
