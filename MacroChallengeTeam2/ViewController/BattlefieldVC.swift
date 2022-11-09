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

    private lazy var pertanyaanCard = CardView(type: .pertanyaan)
    private lazy var ngodingYukCard = CardView(type: .codingCard)
    private lazy var tipsBtn = SmallBackButtonView(variant: .variant4)

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
        view.addSubview(statusLabel)
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

    private lazy var contohBGStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [contohBGInput, contohBGOutput]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var ujiKodinganBtn: SmallButtonView = {
        let btn = SmallButtonView(
            variant: .variant2,
            title: "Uji Kodingan",
            btnType: .normal
        )
        var opened: Bool?
        btn.addAction(
            UIAction { [self] _ in
                if opened == true {
                    backgroundFront.snp.remakeConstraints { make in
                        make.leading.bottom.equalToSuperview()
                        make.width.equalToSuperview()
                        make.top.equalTo(background).offset(8)
                    }
                    animationLayout()
                    opened = nil
                } else {
                    backgroundFront.snp.remakeConstraints { make in
                        make.leading.bottom.equalToSuperview()
                        make.width.equalTo(850) // harusnya panjangnya 850
                        make.top.equalTo(background).offset(8)
                    }
                    animationLayout()
                    opened = true
                }
            },
            for: .touchUpInside
        )
        return btn
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
                    contohBGStackView.snp.updateConstraints { make in
                        make.height.equalTo(0)
                    }
                    animationLayout()
                    currentBtn = nil
                } else {
                    contohBGStackView.snp.updateConstraints { make in
                        make.height.equalTo(200)
                    }
                    animationLayout()
                }
                previousBtn = currentBtn
                }, for: .touchUpInside)
        }
        return contoh
    }()

    private lazy var contohStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: examples)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundFront)
        view.addSubview(backgroundStatus)
        view.addSubview(statusBG)
        view.addSubview(pertanyaanCard)
        view.addSubview(ngodingYukCard)
        view.addSubview(ujiKodinganBtn)
        view.addSubview(tipsBtn)
        view.addSubview(nameCard)
        view.addSubview(hourglass)
        view.addSubview(userName)
        view.addSubview(opponentName)
        view.addSubview(contohStackView)
        view.addSubview(contohBGStackView)

        setupBackground()
        setupDisplays()
        setupComponents()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
        backgroundFront.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalToSuperview() // harusnya panjangnya 850
            make.top.equalTo(background).offset(8)
        }
        backgroundStatus.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        statusBG.snp.makeConstraints { make in
            make.height.equalTo(statusLabel).offset(20)
            make.width.equalTo(statusLabel).offset(48)
            make.centerX.equalTo(nameCard)
            make.top.equalTo(nameCard.snp.bottom)
        }
    }

    private func setupDisplays() {
        nameCard.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundFront)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-10)
        }
        statusLabel.snp.makeConstraints { make in
            make.width.equalTo(statusLabel)
            make.height.equalTo(statusLabel)
            make.center.equalToSuperview()
        }
        hourglass.snp.makeConstraints { make in
            make.leading.equalTo(pertanyaanCard)
            make.bottom.equalTo(pertanyaanCard.snp.top)
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
        pertanyaanCard.snp.makeConstraints { make in
            make.top.equalTo(statusBG.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(backgroundFront.snp.centerX).offset(-8)
            make.bottom.equalTo(contohStackView.snp.top).offset(-23)
        }
        ngodingYukCard.snp.makeConstraints { make in
            make.top.equalTo(pertanyaanCard)
            make.bottom.equalTo(contohBGStackView).offset(5)
            make.trailing.equalTo(backgroundFront).offset(-16)
            make.leading.equalTo(backgroundFront.snp.centerX).offset(8)
        }
        ujiKodinganBtn.snp.makeConstraints { make in
            make.trailing.equalTo(ngodingYukCard).offset(-30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(ngodingYukCard.snp.top)
        }
        tipsBtn.snp.makeConstraints { make in
            make.trailing.equalTo(ujiKodinganBtn.snp.leading).offset(-40)
            make.centerY.equalTo(ujiKodinganBtn)
        }
        contohStackView.snp.makeConstraints { make in
            make.leading.equalTo(pertanyaanCard).offset(5)
            make.bottom.equalTo(contohBGStackView.snp.top)
            make.trailing.equalTo(pertanyaanCard).offset(-5)
        }
        contohBGStackView.snp.makeConstraints { make in
            make.width.equalTo(contohStackView).offset(10)
            make.centerX.equalTo(contohStackView)
            make.bottom.equalTo(backgroundFront).offset(-80)
            make.top.equalTo(contohBGStackView.snp.top)
            make.height.equalTo(0)
        }
    }
    private func animationLayout() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
}

struct BattlefieldViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: BattlefieldViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
