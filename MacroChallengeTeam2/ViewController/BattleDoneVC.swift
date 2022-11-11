//
//  BattleDoneVC.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 10/11/22.
//

import UIKit
import SwiftUI
import Lottie

class BattleDoneVC: UIViewController {
    var onComplete: (() -> Void)?

    private lazy var testCaseBtn: MedButtonView = {
        let button = MedButtonView(
            variant: .variant2,
            title: "Test Case")
        
        button.addVoidAction(onComplete, for: .touchDown)
        
        return button
    }()

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var backgroundMotives: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background4")
        return view
    }()

    private lazy var toaGif: LottieAnimationView = {
        let jsonName = "Toa"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        gif.backgroundBehavior = .pauseAndRestore
        return gif
    }()

    private lazy var heading: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Mantap! Dah Kelar Tandingnya!"
        label.font = .bold34
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var desc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let descContent = NSAttributedString("Sekarang, liat uji kasus buat cek kodingan lo\ntadi bener atau salah.")
            .withLineSpacing(3)
        label.attributedText = descContent
        label.textColor = .white
        label.font = .regular28
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(toaGif)
        view.addSubview(testCaseBtn)
        view.addSubview(heading)
        view.addSubview(desc)

        setupBackground()
        setupDisplays()
        setupComponents()
    }

    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(50)
            make.center.equalToSuperview()
        }
        backgroundMotives.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    private func setupDisplays() {
        heading.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(90)
        }
        desc.snp.makeConstraints { make in
            make.centerX.equalTo(heading)
            make.top.equalTo(heading.snp.bottom).offset(19)
        }
        toaGif.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(400)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(heading.snp.top).offset(-5)
        }
    }

    private func setupComponents() {
        testCaseBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}

struct BattleDoneVCPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return BattleDoneVC()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
