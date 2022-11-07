//
//  Onboarding1VC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 04/11/22.
//

import UIKit
import SnapKit
import SwiftUI
import Lottie

class Onboarding1ViewController: UIViewController {

    private lazy var titleOB: UILabel = {
        let label = UILabel()
        label.text = "Helow!"
        label.font = .bold34
        label.textColor = .white
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()

    private lazy var descOB: UILabel = {
        let label = UILabel()
        label.text = "Selamat datang di Kobar! Lo akan diuji kemampuan koding dengan bertanding." +
        " Harapannya sih bisa nambah wawasan lo dalam logika pemrograman."
        label.font = .regular28
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        return label
    }()

    private lazy var windowGif: LottieAnimationView = {
        let jsonName = "OB1Window"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        gif.backgroundBehavior = .pauseAndRestore
        view.addSubview(gif)
        return gif
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplays()
    }

    private func setupDisplays() {
        titleOB.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(70)
        }
        windowGif.snp.makeConstraints { make in
            make.bottom.equalTo(titleOB.snp.top).offset(-40)
            make.centerX.equalTo(titleOB)
            make.width.equalToSuperview().offset(-850)
            make.height.equalTo(windowGif.snp.width)
        }
        descOB.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleOB.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-500)
        }
    }
}

struct Onboarding1ViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return Onboarding1ViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
