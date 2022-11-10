//
//  PembahasanVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 10/11/22.
//

import UIKit
import SwiftUI
import SnapKit

class PembahasanViewController: UIViewController {
    private lazy var backBtn = SmallIconButtonView(variant: .variant2)
    private lazy var kodingan = CardView(type: .codingCard)
    private lazy var videoPembahasanBtn = BattleContohView(title: "Video Pembahasan")
    private lazy var pembahasanSingkatBtn = BattleContohView(title: "Pembahasan Singkat")

    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background7")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var pembahasanTextView: UITextView = {
        let textView = UITextView.init()
        textView.text = "TestTest"
        textView.textColor = .kobarBlack
        textView.font = UIFont.regular17
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.alpha = 0
        return textView
    }()

    private lazy var pembahasanBG: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.kobarBorderGray.cgColor
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.addSubview(pembahasanTextView)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Yuk Kupas Tuntas"
        label.textColor = .white
        label.font = .bold34
        return label
    }()

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Soal tanding ngajarin tentang pseudocode, input & output,"
        + " sedikit operator, sequence structure, conditional, dan repetition."
        label.textColor = .white
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()

    private lazy var pembahasanSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [videoPembahasanBtn, pembahasanSingkatBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kobarBlueBG
        view.addSubview(background)
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(backBtn)
        view.addSubview(kodingan)
        view.addSubview(pembahasanBG)
        view.addSubview(pembahasanSV)

        setupBackground()
        setupDisplays()
        setupComponents()
        buttonFunction()
    }

    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.bottom.trailing.leading.top.equalToSuperview()
        }
        pembahasanBG.snp.makeConstraints { make in
            make.width.equalTo(pembahasanSV).offset(10)
            make.centerX.equalTo(pembahasanSV)
            make.bottom.equalTo(kodingan)
            make.top.equalTo(pembahasanSV.snp.bottom).offset(4)
        }
    }

    private func setupDisplays() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(43)
            make.centerX.equalTo(titleLabel)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        pembahasanTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    private func setupComponents() {
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(40)
        }
        kodingan.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(descLabel.snp.bottom).offset(50)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.bottom.equalToSuperview().offset(-40)
        }
        pembahasanSV.snp.makeConstraints { make in
            make.top.equalTo(kodingan).offset(5)
            make.leading.equalTo(kodingan.snp.trailing).offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }

    private func buttonFunction() {
        videoPembahasanBtn.addAction(
            UIAction { _ in
                UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                    self.pembahasanTextView.alpha = 0
                }.startAnimation()
            },
            for: .touchUpInside
        )
        pembahasanSingkatBtn.addAction(
            UIAction { [self] _ in
                UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                    self.pembahasanTextView.alpha = 1
                }.startAnimation()
            },
            for: .touchUpInside
        )
        backBtn.addAction(
            UIAction { _ in
                print("Back Button Touched")
            },
            for: .touchUpInside
        )
    }
}

struct PembahasanViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: PembahasanViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
