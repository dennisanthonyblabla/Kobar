//
//  Onboarding3VC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 04/11/22.
//

import UIKit
import SnapKit
import SwiftUI
import Lottie

class Onboarding3ViewController: UIViewController {
    private lazy var titleOB: UILabel = {
        let label = UILabel()
        label.text = "Ada Pembahasan"
        label.font = .bold34
        label.textColor = .white
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()

    private lazy var descOB: UILabel = {
        let label = UILabel()
        label.text = "Dengan adanya pembahasan, lo diharapkan bisa\nbelajar dan nambahin wawasan! " +
        "Eits, gausah takut kalo kalah, yang penting dapat ilmu~"
        label.font = .regular28
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        return label
    }()

    private lazy var paperGif: LottieAnimationView = {
        let jsonName = "OB3Paper"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        gif.backgroundBehavior = .pauseAndRestore
        view.addSubview(gif)
        return gif
    }()

    private lazy var lanjutBtn: MedButtonView = {
        let btn = MedButtonView(variant: .variant2, title: "Lanjut")
        btn.addAction(
            UIAction { _ in
                print("touched")
            },
            for: .touchDown
        )
        view.addSubview(btn)
        return btn
    }()

    private lazy var lewatiBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Lewati Semua", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .regular17
        view.addSubview(btn)
        return btn
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
        paperGif.snp.makeConstraints { make in
            make.bottom.equalTo(titleOB.snp.top).offset(-40)
            make.centerX.equalTo(titleOB)
            make.width.equalToSuperview().offset(-850)
            make.height.equalTo(paperGif.snp.width)
        }
        descOB.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleOB.snp.bottom).offset(20)
            make.width.equalToSuperview().offset(-470)
        }
    }
}

struct Onboarding3ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return Onboarding3ViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
