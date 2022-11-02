//
//  SmallBackButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 19/10/22.
//

import Foundation
import UIKit
import SnapKit

final class DropDownButtonsView: UIButton {

    enum Variants {
        case variant1
        case variant2
        case variant3
    }

    var variant: Variants?

    private lazy var frontBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25.5
        view.backgroundColor = .white
        view.isUserInteractionEnabled = false
        return view
    }()

    private lazy var backBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25.5
        view.backgroundColor = .white
        view.isUserInteractionEnabled = false
        view.alpha = 0.7
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(variant: Variants) {
        super.init(frame: .zero)
        self.variant = variant
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
        let config = UIImage.SymbolConfiguration(pointSize: 22)
        switch variant {
        case .variant1:
            let buttonImage = UIImage(systemName: "gearshape.fill", withConfiguration: config)
            setImage(buttonImage?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
        case .variant2:
            let buttonImage = UIImage(systemName: "speaker.wave.2.fill", withConfiguration: config)
            setImage(buttonImage?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
        case .variant3:
            let buttonImage = UIImage(systemName: "music.note", withConfiguration: config)
            setImage(buttonImage?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)

        case .none:
            let buttonImage = UIImage(systemName: "gearshape.fill", withConfiguration: config)
            setImage(buttonImage?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
        }
    }

    private func setupAutoLayout() {
        backBG.snp.makeConstraints { make in
            make.width.equalTo(frontBG)
            make.height.equalTo(frontBG)
            make.centerX.equalTo(frontBG)
            make.centerY.equalTo(frontBG).offset(4)
        }
        frontBG.snp.makeConstraints { make in
            make.width.equalTo(51)
            make.height.equalTo(51)
            make.center.equalToSuperview()
        }
    }
}
