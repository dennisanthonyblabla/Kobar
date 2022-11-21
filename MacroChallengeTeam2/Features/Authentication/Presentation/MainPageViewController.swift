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
    var onLogout: (() -> Void)?
    
    var picture: String = ""
    var rating: Int = 0

    private lazy var documentationBtn: SmallIconButtonView = {
        let btn = SmallIconButtonView(variant: .variant2, buttonImage: UIImage(systemName: "book.fill"))
        return btn
    }()
    
    private lazy var profileView: ShortProfileView = {
        let view = ShortProfileView(
            rating: rating,
            imageURL: URL(string: picture))
        return view
    }()
    
    private lazy var ajakTemanBtn: MedButtonView = {
        let button = MedButtonView(
            variant: .variant2,
            title: "Ajak Teman")
        
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
            title: "Gabung Teman")
        
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
            title: "Siapa Aja Bebas")
        
        button.addAction(
            UIAction { _ in
                self.onJoinRandom?()
            },
            for: .touchDown)
        
        return button
    }()
    
    private lazy var logOutBtn: SmallIconButtonView = {
        let button = SmallIconButtonView(
            variant: .variant2,
            buttonImage: UIImage(systemName: "rectangle.portrait.and.arrow.right"))
        
        button.addAction(
            UIAction { _ in
                self.onLogout?()
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
        
        ajakTemanBtn.snp.makeConstraints { make in
            make.width.equalTo(245)
        }
        gabungBtn.snp.makeConstraints { make in
            make.width.equalTo(245)
        }
        siapaAjaBtn.snp.makeConstraints { make in
            make.width.equalTo(245)
        }
        
        view.addArrangedSubview(ajakTemanBtn)
        view.addArrangedSubview(gabungBtn)
        view.addArrangedSubview(siapaAjaBtn)
        
        view.spacing = 80
        
        return view
    }()
    
    private lazy var swordGif: LottieAnimationView = {
        let jsonName = "MainPageSword"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swordGif.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(tandingYukTitle)
        view.addSubview(tandingYukDesc)
        view.addSubview(swordGif)
        view.addSubview(profileView)
        view.addSubview(buttonsStackView)
        view.addSubview(logOutBtn)
        view.addSubview(documentationBtn)
        
        setupBackgroundConstraints()
        setupDisplayConstraint()
        setupComponentsConstraint()
        documentationFunc()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        swordGif.stop()
        super.viewWillDisappear(animated)
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
        profileView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(89)
            make.centerY.equalTo(logOutBtn)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        logOutBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(96)
        }
        documentationBtn.snp.makeConstraints { make in
            make.trailing.equalTo(logOutBtn.snp.leading).offset(-20)
            make.centerY.equalTo(logOutBtn)
        }
    }

    private func documentationFunc() {
        documentationBtn.addAction(
            UIAction { [self] _ in
                let controller = DokumentasiPageVC()
                
                controller.onClose = { [unowned self] in
                    self.dismiss(animated: true)
                }
               
                navigationController?.present(controller, animated: true)
            }, for: .touchDown)
    }
}

struct MainPageViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: MainPageViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
