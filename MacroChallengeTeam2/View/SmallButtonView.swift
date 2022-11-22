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
    
    private var isPressed = false {
        didSet {
            updateTextPadding()
        }
    }
    
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

    private func setupVariants() {
        setTitle(title, for: .normal)
        switch variant {
        case .variant1:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            setupButtonConfiguration(.white)
        case .variant2:
            self.frontBG.backgroundColor = .white
            self.backBG.backgroundColor = .white
            self.backBG.alpha = 0.7
            setupButtonConfiguration(.kobarBlueActive)
        case .variant3:
            self.frontBG.backgroundColor = .kobarGray
            self.backBG.backgroundColor = .kobarDarkGray
            setupButtonConfiguration(.kobarDarkGrayText)
        case .none:
            self.frontBG.backgroundColor = .kobarBlueActive
            self.backBG.backgroundColor = .kobarDarkBlue
            setupButtonConfiguration(.white)
        }
    }
    
    private func setupButtonConfiguration(_ titleColor: UIColor) {
        let config = UIImage.SymbolConfiguration(pointSize: 14)
        
        configuration = .plain()
        configuration?.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .semi17
                outgoing.foregroundColor = titleColor
                return outgoing
            }
        configuration?.imagePadding = 10
        configuration?.image = icon?
            .withConfiguration(config)
            .withTintColor(titleColor, renderingMode: .alwaysOriginal)
        
        updateTextPadding()
    }
    
    private func updateTextPadding() {
        if isPressed {
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 12, trailing: 0)
        } else {
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 16, trailing: 0)
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
            make.top.equalToSuperview().offset(isPressed ? 5 : 0)
            make.bottom.equalToSuperview().offset(isPressed ? 0 : -5)
        }

        // according to Apple super should be called at end of method
        super.updateConstraints()
    }
}
