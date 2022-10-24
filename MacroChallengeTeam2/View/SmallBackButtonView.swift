//
//  SmallBackButtonView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 19/10/22.
//

import Foundation
import UIKit
import SnapKit

final class SmallBackButtonView: UIButton {

    enum Variants {
        case variant1
        case variant2
        case variant3
    }

    var variant: Variants = .variant1 {
        didSet {
            self.configuration = .plain()
            let config = UIImage.SymbolConfiguration(pointSize: 22)
            let buttonImage = UIImage(systemName: "arrowshape.backward.fill", withConfiguration: config)
            switch variant {
            case .variant1:
                setImage(buttonImage?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
                self.frontBG.backgroundColor = .kobarBlueActive
                self.backBG.backgroundColor = .kobarDarkBlue
                self.backBG.layer.opacity = 1
                self.alpha = 1
            case .variant2:
                setImage(buttonImage?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
                self.frontBG.backgroundColor = .white
                self.backBG.backgroundColor = .white
                self.backBG.layer.opacity = 0.7
                self.alpha = 1
            case .variant3:
                setImage(buttonImage?.withTintColor(.kobarBlueActive, renderingMode: .alwaysOriginal), for: .normal)
                self.frontBG.backgroundColor = .white
                self.backBG.backgroundColor = .white
                self.backBG.layer.opacity = 0.7
                self.alpha = 0.7
            }
        }
    }

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
        addSubview(backBG)
        addSubview(frontBG)
        setupButton()
        setupAutoLayout()
    }

    init(image: UIImage) {
        super.init(frame: .zero)

    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        backBG.snp.makeConstraints { (make) in
            make.width.equalTo(frontBG)
            make.height.equalTo(frontBG)
            make.centerX.equalTo(frontBG)
            make.centerY.equalTo(frontBG).offset(4)
        }
        frontBG.snp.makeConstraints { (make) in
            make.width.equalTo(51)
            make.height.equalTo(51)
            make.center.equalToSuperview()
        }
    }

    private func setupButton() {
        configuration = .plain()
        let config = UIImage.SymbolConfiguration(pointSize: 22)
        let buttonImage = UIImage(systemName: "arrowshape.backward.fill", withConfiguration: config)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(buttonImage?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
}
