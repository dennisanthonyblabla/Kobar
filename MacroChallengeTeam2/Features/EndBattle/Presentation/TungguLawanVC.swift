//
//  TungguLawanVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 01/11/22.
//

import UIKit
import SnapKit
import SwiftUI
import Lottie

class TungguLawanViewController: UIViewController {
    var onShowReview: (() -> Void)?
    var onNewBattle: (() -> Void)?
    
    var endDate: Date = .now
    
    private lazy var tandingBaruBtn: MedButtonView = {
        let button = MedButtonView(
        variant: .variant3,
        title: "Tanding Baru")
        button.addVoidAction(onNewBattle, for: .touchUpInside)
        return button
    }()
    
    private lazy var pembahasanBtn: MedButtonView = {
        let button = MedButtonView(
        variant: .variant2,
        title: "Pembahasan")
        button.addVoidAction(onShowReview, for: .touchUpInside)
        return button
    }()

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var backgroundMotives: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background4")
        return view
    }()

    private lazy var hourglassGif: LottieAnimationView = {
        let jsonName = "Hourglass"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        gif.backgroundBehavior = .pauseAndRestore
        return gif
    }()

    private lazy var timerLabel: CountdownLabelView = {
        let timer = CountdownLabelView(endDate: endDate)
        timer.font = .bold38
        timer.textColor = .white
        return timer
    }()

    private lazy var pantun: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let isiPantun = NSAttributedString(
            string: "Ada cicak di dinding\nKenceng bunyinya\nCepet banget lo ngoding\nSabar nunggu lawan lo kelar ya"
        ).withLineSpacing(3)
        label.attributedText = isiPantun
        label.font = .semi28
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var desc: UILabel = {
        let label = UILabel()
        label.text = "Lawan lo kelar sekitar..."
        label.textColor = .white
        label.font = .regular22
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(hourglassGif)
        view.addSubview(tandingBaruBtn)
        view.addSubview(pembahasanBtn)
        view.addSubview(pantun)
        view.addSubview(desc)
        view.addSubview(timerLabel)

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
        pantun.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(70)
        }
        desc.snp.makeConstraints { make in
            make.centerX.equalTo(pantun)
            make.top.equalTo(pantun.snp.bottom).offset(19)
        }
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(desc)
            make.top.equalTo(desc.snp.bottom).offset(2)
        }
        hourglassGif.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(330)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pantun.snp.top).offset(-5)
        }
    }

    private func setupComponents() {
        tandingBaruBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-170)
            make.width.equalTo(200)
            make.bottom.equalToSuperview().offset(-100)
        }
        pembahasanBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(170)
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(200)
        }
    }
}

struct TungguLawanViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return TungguLawanViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
