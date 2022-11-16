//
//  SmallBackButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 19/10/22.
//

import Foundation
import UIKit
import SnapKit

final class SmallIconButtonView: UIButton {
    enum Variants {
        case variant1
        case variant2
        case variant3
    }

    var variant: Variants?
    var buttonIcon: UIImage?

    private lazy var frontBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25.5
        view.backgroundColor = .kobarBlueActive
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var backBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25.5
        view.backgroundColor = .kobarDarkBlue
        view.isUserInteractionEnabled = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(
        variant: Variants,
        buttonImage: UIImage? = UIImage(systemName: "chevron.left")
    ) {
        super.init(frame: .zero)
        self.variant = variant
        self.buttonIcon = buttonImage
        addSubview(backBG)
        addSubview(frontBG)
        setupButtonVariant()
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtonVariant() {
        configuration = .plain()
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 12)
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)
        buttonIcon = buttonIcon?.withConfiguration(config)
        switch variant {
        case .variant1:
            setImage(buttonIcon?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            frontBG.backgroundColor = .kobarBlueActive
            backBG.backgroundColor = .kobarDarkBlue
            backBG.layer.opacity = 1
            alpha = 1
        case .variant2:
            setImage(buttonIcon?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
            frontBG.backgroundColor = .white
            backBG.backgroundColor = .white
            backBG.layer.opacity = 0.7
            alpha = 1
        case .variant3:
            setImage(buttonIcon?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
            frontBG.backgroundColor = .white
            backBG.backgroundColor = .white
            backBG.layer.opacity = 0.7
            alpha = 0.7
        case .none:
            setImage(buttonIcon?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            frontBG.backgroundColor = .kobarBlueActive
            backBG.backgroundColor = .kobarDarkBlue
            backBG.layer.opacity = 1
            alpha = 1
        }
    }

    private func setupAutoLayout() {
        self.snp.makeConstraints { make in
            make.height.width.equalTo(54)
        }

        backBG.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        frontBG.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
            make.centerX.equalToSuperview()
        }
    }
}
