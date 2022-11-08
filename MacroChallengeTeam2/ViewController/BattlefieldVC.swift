//
//  BattlefieldVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 02/11/22.
//

import UIKit
import SnapKit
import SwiftUI

class BattlefieldViewController: UIViewController {
    private var statusDesc: String?
    private var contohCount = 3

    private lazy var pertanyaan = CardView(type: .pertanyaan)
    private lazy var ngodingYuk = CardView(type: .codingCard)
    private lazy var ujiKodingan = SmallButtonView(variant: .variant2, title: "Uji Kodingan", btnType: .normal)
    private lazy var tips = SmallBackButtonView(variant: .variant2)

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarDarkBlueBG
        return view
    }()

    private lazy var backgroundFront: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueActive
        return view
    }()

    private lazy var backgroundStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var statusBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarDarkBlueBG
        view.layer.cornerRadius = 20.5
        return view
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Tenang! Lawan lo masih ngerjain kok"
        label.font = .regular17
        label.textColor = .white
        return label
    }()

    private lazy var hourglass: UILabel = {
        let label = UILabel()
        label.text = "⌛️"
        label.font = .semi36
        return label
    }()

    private lazy var nameCard: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "versusNameCard")
        return view
    }()

    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = .bold22
        label.textColor = .kobarBlack
        label.textAlignment = .right
        return label
    }()

    private lazy var opponentName: UILabel = {
        let label = UILabel()
        label.text = "Jane Doe"
        label.font = .bold22
        label.textColor = .kobarBlack
        label.textAlignment = .left
        return label
    }()

    private lazy var contohBGInput: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.kobarBorderGray.cgColor
        return view
    }()

    private lazy var contohBGOutput: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.kobarBorderGray.cgColor
        return view
    }()

    private lazy var examples: [BattleContohView] = {
        var contoh: [BattleContohView] = []
        var previousBtn: Int?
        var currentBtn: Int?
        for i in 1...contohCount {
            contoh.append(BattleContohView(title: "contoh " + "(\(i))"))
        }

        for (index, i) in contoh.enumerated() {
            i.addAction(
                UIAction { [self]_ in
                currentBtn = index
                if previousBtn == currentBtn {
                    svContoh.snp.remakeConstraints { make in
                        make.leading.equalToSuperview().offset(26)
                        make.bottom.equalToSuperview().offset(-80)
                        make.trailing.equalTo(view.snp.centerX).offset(-20)
                    }
                    contohBGInput.snp.removeConstraints()
                    contohBGOutput.snp.removeConstraints()

                    currentBtn = nil
                } else {
                    contohBGInput.snp.makeConstraints { make in
                        make.leading.equalTo(pertanyaan)
                        make.trailing.equalTo(pertanyaan.snp.centerX)
                        make.height.equalTo(200)
                        make.bottom.equalToSuperview().offset(-75)
                    }
                    contohBGOutput.snp.makeConstraints { make in
                        make.trailing.equalTo(pertanyaan)
                        make.leading.equalTo(pertanyaan.snp.centerX)
                        make.height.equalTo(200)
                        make.bottom.equalToSuperview().offset(-75)
                    }
                    svContoh.snp.remakeConstraints { make in
                        make.leading.equalToSuperview().offset(26)
                        make.trailing.equalTo(view.snp.centerX).offset(-18)
                        make.bottom.equalTo(contohBGInput.snp.top).offset(-4.5)
                    }
                }
                previousBtn = currentBtn
                }, for: .touchUpInside)
        }
        return contoh
    }()

    private lazy var svContoh: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: examples)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundFront)
        view.addSubview(backgroundStatus)
        view.addSubview(statusBG)
        view.addSubview(statusLabel)
        view.addSubview(pertanyaan)
        view.addSubview(ngodingYuk)
        view.addSubview(ujiKodingan)
        view.addSubview(tips)
        view.addSubview(nameCard)
        view.addSubview(hourglass)
        view.addSubview(userName)
        view.addSubview(opponentName)
        view.addSubview(contohBGInput)
        view.addSubview(contohBGOutput)

        setupBackground()
        setupDisplays()
        setupComponents()
        setupButtonTarget()
    }

    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(50)
            make.center.equalToSuperview()
        }
        backgroundFront.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-5)
            make.center.equalToSuperview()
        }
        backgroundStatus.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(-24)
        }
        statusBG.snp.makeConstraints { make in
            make.height.equalTo(41)
            make.width.equalTo(statusLabel).offset(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameCard.snp.bottom)
        }
    }

    private func setupDisplays() {
        nameCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-15)
        }
        statusLabel.snp.makeConstraints { make in
            make.width.equalTo(statusLabel)
            make.height.equalTo(statusLabel)
            make.center.equalTo(statusBG)
        }
        hourglass.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalTo(pertanyaan.snp.top)
            make.top.equalTo(backgroundFront)
        }
        userName.snp.makeConstraints { make in
            make.centerY.equalTo(nameCard).offset(-4)
            make.trailing.equalTo(nameCard.snp.centerX).offset(-40)
        }
        opponentName.snp.makeConstraints { make in
            make.centerY.equalTo(nameCard).offset(-4)
            make.leading.equalTo(nameCard.snp.centerX).offset(40)
        }
    }

    private func setupComponents() {
        pertanyaan.snp.makeConstraints { make in
            make.top.equalTo(statusBG.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(view.snp.centerX).offset(-8)
            make.bottom.equalTo(svContoh.snp.top).offset(-23)
        }
        ngodingYuk.snp.makeConstraints { make in
            make.height.equalTo(593)
            make.top.equalTo(pertanyaan)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(view.snp.centerX).offset(8)
        }
        ujiKodingan.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-45)
            make.top.equalToSuperview()
            make.bottom.equalTo(ngodingYuk.snp.top)
        }
        tips.snp.makeConstraints { make in
            make.trailing.equalTo(ujiKodingan.snp.leading).offset(-40)
            make.centerY.equalTo(ujiKodingan)
        }
        svContoh.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.bottom.equalToSuperview().offset(-80)
            make.trailing.equalTo(view.snp.centerX).offset(-18)
        }
//        contoh1.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(46)
//            make.bottom.equalToSuperview().offset(-80)
//        }
//        contoh2.snp.makeConstraints { make in
//            make.leading.equalTo(contoh1).offset(189)
//            make.bottom.equalTo(contoh1)
//        }
//        contoh3.snp.makeConstraints { make in
//            make.leading.equalTo(contoh2).offset(189)
//            make.bottom.equalTo(contoh1)
//        }
    }

    private func setupButtonTarget() {
//        examples[0].addTarget(self, action: #selector(contoh1Clicked), for: .touchUpInside)
    }

    @objc func contoh1Clicked() {
    }
}

struct BattlefieldViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return BattlefieldViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
