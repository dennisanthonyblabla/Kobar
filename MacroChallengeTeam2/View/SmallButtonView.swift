//
//  SmallButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 01/11/22.
//

import UIKit
import SnapKit

final class SmallButtonView: UIButton {
    enum Variants {
        case variant1
        case variant2
        case variant3
    }
    
    private var isPressed = false
    
    private var title: String?
    private var icon: UIImage?
    private var variant: Variants?

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

    init(variant: Variants, title: String, icon: UIImage? = nil) {
        super.init(frame: .zero)
        self.title = title
        self.variant = variant
        self.icon = icon
        addSubview(backBG)
        addSubview(frontBG)
        
        setupButtonConfiguration()
        setupVariants()
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        backBG.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.width.equalToSuperview()
        }

        frontBG.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    private func setupButtonConfiguration() {
        configuration = .plain()
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0)
        configuration?.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .semi17
                return outgoing
            }
    }

    private func setupVariants() {
        setTitle(title, for: .normal)
        titleLabel?.font = .bold17
        
        let config = UIImage.SymbolConfiguration(pointSize: 17)
        let icon = self.icon?.withConfiguration(config)
        
        switch variant {
        case .variant1:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            self.setTitleColor(.white, for: .normal)
            self.icon = icon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .variant2:
            self.frontBG.backgroundColor = .white
            self.backBG.backgroundColor = .white
            self.backBG.alpha = 0.7
            self.setTitleColor(.kobarBlueActive, for: .normal)
            self.icon = icon?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal)
        case .variant3:
            self.frontBG.backgroundColor = .kobarGray
            self.backBG.backgroundColor = .kobarDarkGray
            self.setTitleColor(.kobarDarkGrayText, for: .normal)
            self.icon = icon?.withTintColor(.kobarDarkGrayText, renderingMode: .alwaysOriginal)
        case .none:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            self.setTitleColor(.white, for: .normal)
            self.icon = icon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
        
        configuration?.imagePadding = 10
        configuration?.image = self.icon
    }
    
    override func updateConstraints() {
        frontBG.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(isPressed ? 5 : 0)
            make.bottom.equalToSuperview().offset(isPressed ? 0 : -5)
        }

        // according to Apple super should be called at end of method
        super.updateConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isPressed = true
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 12, trailing: 0)
        layoutIfNeeded()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = false
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0)
        layoutIfNeeded()
        super.touchesEnded(touches, with: event)
    }
}
