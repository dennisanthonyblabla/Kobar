//
//  MPContohView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 03/11/22.
//

import UIKit
import SnapKit

class BattleContohView: UIButton {
    enum Selection {
        case selected
        case notSelected
    }
    var isItSelected: Selection? {
        didSet {
            checkIfSelected()
        }
    }
    private var image: String?
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

    init(title: String, image: String? = "", selected: Selection) {
        super.init(frame: .zero)
        self.image = image
        self.isItSelected = selected
        addSubview(titleBanner)
        setupButton(title: title)
        setupAutoLayout()
        checkIfSelected()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton(title: String) {
        var config = UIButton.Configuration.plain()
        config.imagePadding = 1
        configuration = config
        let buttonImage = UIImage(systemName: image ?? "")
        setImage(buttonImage?.withTintColor(.kobarBlack, renderingMode: .alwaysOriginal), for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(.kobarBlack, for: .normal)
        titleLabel?.font = .regular17
//        configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }

    private func setupAutoLayout() {
        titleBanner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(10)
            make.bottom.equalTo(10)
            make.height.equalTo(44)
        }
    }

    private func checkIfSelected() {
        switch isItSelected {
        case .selected:
            if image == "chevron.down"{
                self.setImage(
                    UIImage(systemName: "chevron.up")?
                    .withTintColor(
                        .kobarBlueActive,
                        renderingMode: .alwaysOriginal
                    ), for: .normal
                )
            } else {
                self.setImage(
                    UIImage(systemName: image ?? "")?
                    .withTintColor(
                        .kobarBlueActive,
                        renderingMode: .alwaysOriginal
                    ), for: .normal
                )
            }
            self.setTitleColor(.kobarBlueActive, for: .normal)
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
            titleBanner.snp.updateConstraints { make in
                make.height.equalTo(54)
            }
        case .notSelected:
            self.setImage(
                UIImage(systemName: image ?? "")?
                .withTintColor(
                    .kobarBlack,
                    renderingMode: .alwaysOriginal
                ), for: .normal
            )
            self.setTitleColor(.kobarBlack, for: .normal)
            configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            titleBanner.snp.updateConstraints { make in
                make.height.equalTo(44)
            }
        case .none:
            break
        }
    }
}
