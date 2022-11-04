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
        case fixedWidth
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
        setupButtonConfiguration()
        setupVariants()
        if variant == .fixedWidth {
            setupAutoLayoutMP()
        } else {
            setupAutoLayout()
        }

        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress))
        gestureRecognizer.minimumPressDuration = 0.01
        self.addGestureRecognizer(gestureRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButtonConfiguration() {
        self.configuration = .plain()
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 32, bottom: 14, trailing: 32)
        configuration?.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .semi17
                return outgoing
            }
    }

    private func setupVariants() {
        setTitle(title, for: .normal)
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
        case .fixedWidth:
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
        self.snp.makeConstraints { make in
            make.height.equalTo(64)
        }

        backBG.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.bottom.width.equalToSuperview()
        }

        frontBG.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(backBG)
        }
    }

    private func setupAutoLayoutMP() {
        backBG.snp.makeConstraints { make in
            make.height.width.equalTo(frontBG)
            make.centerX.equalTo(frontBG)
            make.centerY.equalTo(frontBG).offset(5)
        }

        frontBG.snp.makeConstraints { make in
            make.height.equalTo(59)
            make.width.equalTo(245)
            make.center.equalToSuperview()
        }
    }

    @objc func onLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            isPressed = true
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 32, bottom: 8, trailing: 32)
            layoutIfNeeded()
        }

        if gestureRecognizer.state == .ended {
            isPressed = false
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 32, bottom: 14, trailing: 32)
            layoutIfNeeded()
        }
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
