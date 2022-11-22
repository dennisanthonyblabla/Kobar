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

    var isPressed = false {
        didSet {
            updateTextPadding()
        }
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
        setupButtonConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtonVariant() {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
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
    
    private func setupButtonConfiguration() {
        configuration = .plain()
        
        updateTextPadding()
    }
    
    private func updateTextPadding() {
        if isPressed {
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 8, trailing: 0)
        } else {
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isPressed = true
        layoutIfNeeded()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = false
        layoutIfNeeded()
        super.touchesEnded(touches, with: event)
    }
    
    override func updateConstraints() {
        frontBG.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(isPressed ? 4 : 0)
            make.bottom.equalToSuperview().offset(isPressed ? 0 : -4)
        }

        // according to Apple super should be called at end of method
        super.updateConstraints()
    }
}
