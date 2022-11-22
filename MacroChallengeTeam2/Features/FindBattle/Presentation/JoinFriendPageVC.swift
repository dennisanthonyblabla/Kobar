//
//  JoinFriendPageVC.swift
//  Kobar
//
//  Created by Dennis Anthony on 22/11/22.
//

import UIKit
import SwiftUI
import SnapKit

class JoinFriendViewController: UIViewController {
    private var isInputTrue: Bool?

    private lazy var batalBtn = SmallButtonView(variant: .variant3, title: "Batal", btnType: .normal)
    private lazy var gabungBtn = SmallButtonView(variant: .variant1, title: "Gabung", btnType: .normal)

    private lazy var backgroundMotives: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "notificationCard")
        return imageView
    }()

    private lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.text = "Gabung Teman"
        label.font = .semi28
        label.textColor = .white
        return label
    }()

    private lazy var desc: UILabel = {
        let label = UILabel()
        label.text = "Masukin Kodenya"
        label.textColor = .kobarBlack
        label.font = .regular22
        return label
    }()

    private lazy var textInput: UITextField = {
        let input = UITextField()
        input.placeholder = "Ketik Kode"
        input.textAlignment = .center
        input.textColor = .kobarBlack
        input.backgroundColor = .kobarGray
        input.font = .regular24
        input.clipsToBounds = true
        input.layer.cornerRadius = 20
        input.layer.borderColor = UIColor.kobarRed.cgColor
        input.autocapitalizationType = .allCharacters
        input.autocorrectionType = .no
        return input
    }()

    private lazy var buttonsSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [batalBtn, gabungBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var warning: UILabel = {
        let label = UILabel()
        label.text = "Kode tidak boleh kosong"
        label.textColor = .kobarRed
        label.font = .regular15
        label.alpha = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundMotives)
        view.addSubview(cardTitle)
        view.addSubview(desc)
        view.addSubview(textInput)
        view.addSubview(buttonsSV)
        view.addSubview(warning)

        setupAutoLayout()
        buttonSetup()
    }

    private func buttonSetup() {
        batalBtn.addAction(
            UIAction { _ in

            }, for: .touchUpInside)

        gabungBtn.addAction(
            UIAction { [self] _ in
                if textInput.hasText == false {
                    textInput.layer.borderWidth = 2
                    warning.alpha = 1
                } else {
                    textInput.layer.borderWidth = 0
                    warning.alpha = 0
                }
            }, for: .touchUpInside)
    }

    private func setupAutoLayout() {
        backgroundMotives.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        cardTitle.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundMotives)
            make.top.equalTo(backgroundMotives).offset(20)
        }
        desc.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundMotives)
            make.top.equalTo(cardTitle.snp.bottom).offset(40)
        }
        textInput.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundMotives)
            make.top.equalTo(desc.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.width.equalTo(backgroundMotives).inset(90)
        }
        buttonsSV.snp.makeConstraints { make in
            make.width.equalTo(backgroundMotives).inset(70)
            make.height.equalTo(buttonsSV.snp.height)
            make.centerX.equalTo(backgroundMotives)
            make.bottom.equalTo(backgroundMotives).offset(-60)
        }
        warning.snp.makeConstraints { make in
            make.top.equalTo(textInput.snp.bottom).offset(10)
            make.centerX.equalTo(backgroundMotives)
        }
    }
}

struct JoinFriendPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: JoinFriendViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
