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
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        let config = UIImage.SymbolConfiguration(pointSize: 17)
        let profile = icon?.withConfiguration(config)
        imageView.image = profile?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    init(variant: Variants, title: String, icon: UIImage? = nil) {
        super.init(frame: .zero)
        self.title = title
        self.variant = variant
        self.icon = icon
        
        addSubview(backBG)
        addSubview(frontBG)
        addSubview(iconImageView)
        
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
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(frontBG)
            make.leading.equalTo(frontBG).offset(30)
        }
    }

    private func setupVariants() {
        setTitle(title, for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 17)
        let icon = self.icon?.withConfiguration(config)
        switch variant {
        case .variant1:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            setupButtonConfiguration(.white)
            self.iconImageView.image = icon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .variant2:
            self.frontBG.backgroundColor = .white
            self.backBG.backgroundColor = .white
            self.backBG.alpha = 0.7
            setupButtonConfiguration(.kobarBlueActive)
            self.iconImageView.image = icon?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal)
        case .variant3:
            self.frontBG.backgroundColor = .kobarGray
            self.backBG.backgroundColor = .kobarDarkGray
            setupButtonConfiguration(.kobarDarkGrayText)
            self.iconImageView.image = icon?.withTintColor(.kobarDarkGrayText, renderingMode: .alwaysOriginal)
        case .none:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            setupButtonConfiguration(.white)
            self.iconImageView.image = icon?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    private func setupButtonConfiguration(_ titleColor: UIColor) {
        let leading: CGFloat = icon == nil ? 0 : 25
        
        configuration = .plain()
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: leading, bottom: 16, trailing: 0)
        configuration?.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .semi17
                outgoing.foregroundColor = titleColor
                return outgoing
            }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let leading: CGFloat = icon == nil ? 0 : 25
        
        isPressed = true
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: leading, bottom: 12, trailing: 0)
        layoutIfNeeded()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let leading: CGFloat = icon == nil ? 0 : 25
        isPressed = false
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: leading, bottom: 16, trailing: 0)
        layoutIfNeeded()
        super.touchesEnded(touches, with: event)
    }
    
    override func updateConstraints() {
        frontBG.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(isPressed ? 5 : 0)
            make.bottom.equalToSuperview().offset(isPressed ? 0 : -5)
        }

        // according to Apple super should be called at end of method
        super.updateConstraints()
    }
}
