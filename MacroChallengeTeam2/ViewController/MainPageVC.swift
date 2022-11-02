//
//  MainPageViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 26/10/22.
//

import UIKit
import SnapKit
import SwiftUI
import Lottie

class MainPageViewController: UIViewController {

    private lazy var profile = ShortProfileView(rating: 2000)
    private lazy var ajakTemanBtn = MedbuttonView(variant: .fixedWidth, title: "Ajak Teman")
    private lazy var gabungBtn = MedbuttonView(variant: .fixedWidth, title: "Gabung Sama Teman")
    private lazy var siapaAjaBtn = MedbuttonView(variant: .fixedWidth, title: "Siapa Aja Bebas")

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var backgroundMotives: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "pageTandingYukBG")
        return view
    }()

    private lazy var swordGif: LottieAnimationView = {
        let jsonName = "MainPageSword"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        return gif
    }()

    private lazy var tandingYukTitle: UILabel = {
        let label = UILabel()
        label.text = "Tanding Yuk!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .bold34
        return label
    }()

    private lazy var tandingYukDesc: UILabel = {
        let label = UILabel()
        label.text = "Uji Kemampuan koding lo dengan cus pilih lawan lo!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .regular28
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(tandingYukTitle)
        view.addSubview(tandingYukDesc)
        view.addSubview(swordGif)
        view.addSubview(profile)
        view.addSubview(ajakTemanBtn)
        view.addSubview(gabungBtn)
        view.addSubview(siapaAjaBtn)

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
        tandingYukTitle.snp.makeConstraints { make in
            make.width.equalTo(tandingYukTitle.snp.width)
            make.height.equalTo(tandingYukTitle.snp.height)
            make.centerY.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
        }
        tandingYukDesc.snp.makeConstraints { make in
            make.width.equalTo(tandingYukDesc.snp.width)
            make.height.equalTo(tandingYukDesc.snp.height)
            make.top.equalTo(tandingYukTitle.snp.bottom).offset(8)
            make.centerX.equalTo(tandingYukTitle)
        }
        swordGif.snp.makeConstraints { make in
            make.width.equalTo(480)
            make.height.equalTo(480)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
        }
    }

    private func setupComponents() {
        profile.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(89)
            make.top.equalToSuperview().offset(100)
        }
        gabungBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        ajakTemanBtn.snp.makeConstraints { make in
            make.trailing.equalTo(gabungBtn.snp.leading).offset(-200)
            make.centerY.equalTo(gabungBtn)
        }
        siapaAjaBtn.snp.makeConstraints { make in
            make.leading.equalTo(gabungBtn.snp.trailing).offset(200)
            make.centerY.equalTo(gabungBtn)
        }
    }
}

struct MainPageViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return MainPageViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
