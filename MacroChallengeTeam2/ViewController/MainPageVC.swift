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
    var onInviteFriend: (() -> Void)?
    var onJoinFriend: (() -> Void)?
    var onJoinRandom: (() -> Void)?
    
    private lazy var profile = ShortProfileView(rating: 2000)
    
    private lazy var ajakTemanBtn: MedButtonView = {
        let button = MedButtonView(
            variant: .variant2,
            title: "Ajak Teman",
            width: 245)
        
        button.addAction(
            UIAction { _ in
                self.onInviteFriend?()
            },
            for: .touchDown)
        
        return button
    }()
    
    private lazy var gabungBtn: MedButtonView = {
        let button = MedButtonView(
            variant: .variant2,
            title: "Gabung Sama Teman",
            width: 245)
        
        button.addAction(
            UIAction { _ in
                self.onJoinFriend?()
            },
            for: .touchDown)
        
        return button
    }()
    
    private lazy var siapaAjaBtn: MedButtonView = {
        let button = MedButtonView(
            variant: .variant2,
            title: "Siapa Aja Bebas",
            width: 245)
        
        button.addAction(
            UIAction { _ in
                self.onJoinRandom?()
            },
            for: .touchDown)
        
        return button
    }()
    
    private lazy var background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background1")
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.addArrangedSubview(ajakTemanBtn)
        view.addArrangedSubview(gabungBtn)
        view.addArrangedSubview(siapaAjaBtn)
        
        view.spacing = 40
        
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
        view.addSubview(tandingYukTitle)
        view.addSubview(tandingYukDesc)
        view.addSubview(swordGif)
        view.addSubview(profile)
        view.addSubview(buttonsStackView)
        
        setupBackgroundConstraints()
        setupDisplayConstraint()
        setupComponentsConstraint()
    }
    
    private func setupBackgroundConstraints() {
        background.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
    
    private func setupDisplayConstraint() {
        tandingYukTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
        }
        tandingYukDesc.snp.makeConstraints { make in
            make.top.equalTo(tandingYukTitle.snp.bottom).offset(8)
            make.centerX.equalTo(tandingYukTitle)
        }
        swordGif.snp.makeConstraints { make in
            make.height.width.equalTo(400)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
        }
    }
    
    private func setupComponentsConstraint() {
        profile.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(89)
            make.top.equalToSuperview().offset(100)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tandingYukDesc).offset(50)
        }
    }
}

struct MainPageViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return MainPageViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
