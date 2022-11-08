//
//  MPContohView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 03/11/22.
//

import UIKit
import SnapKit

class BattleContohView: UIButton {
    private lazy var titleBanner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarGrayContoh
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isUserInteractionEnabled = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(title: String) {
        super.init(frame: .zero)
        addSubview(titleBanner)
        setupAutoLayout()
        setupButton(title: title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton(title: String) {
        var config = UIButton.Configuration.plain()
        config.imagePadding = 5
        config.titlePadding = 5
        configuration = config
        let buttonImage = UIImage(systemName: "chevron.down")
        setImage(buttonImage?.withTintColor(.kobarBlack, renderingMode: .alwaysOriginal), for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(.kobarBlack, for: .normal)
        titleLabel?.font = .regular17
    }

    private func setupAutoLayout() {
        titleBanner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(20)
            make.height.equalTo(43)
        }
    }
}
