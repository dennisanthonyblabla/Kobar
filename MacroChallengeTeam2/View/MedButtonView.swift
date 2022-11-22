//
//  MedButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 26/10/22.
//

import Foundation
import UIKit
import SnapKit

final class MedButtonView: UIButton {
    enum Variants {
        case variant1
        case variant2
        case variant3
    }

    private var variant: Variants?
    private var title: String?
    private var isPressed = false

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
        
        setupVariants()
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    private func setupAutoLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(64)
        }

        backBG.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.width.equalToSuperview()
        }

        frontBG.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-6)
        }
    }

    private func setupButtonConfiguration(_ titleColor: UIColor) {
        configuration = .plain()
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 32, bottom: 14, trailing: 32)
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

    override func updateConstraints() {
        frontBG.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(isPressed ? 6 : 0)
            make.bottom.equalToSuperview().offset(isPressed ? 0 : -6)
        }

        // according to Apple super should be called at end of method
        super.updateConstraints()
    }
}
