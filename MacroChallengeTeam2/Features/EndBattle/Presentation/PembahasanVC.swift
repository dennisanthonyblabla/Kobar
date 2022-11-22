//
//  PembahasanVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 10/11/22.
//

import UIKit
import SwiftUI
import SnapKit
import WebKit

class PembahasanViewController: UIViewController, WKUIDelegate {
    var onBack: (() -> Void)?
    
    var code: String = ""
    var reviewText: String = ""
    var reviewVideoURL: String = ""
    
    private lazy var backBtn: SmallIconButtonView = {
        let button = SmallIconButtonView(variant: .variant2)
        button.addVoidAction(onBack, for: .touchUpInside)
        return button
    }()
    
    private lazy var kodingan: CardView = {
        let view = CardView(type: .codeReview, isEditable: false)
        
        view.text = code
        view.textColor = .kobarBlack
        
        return view
    }()
    
    private lazy var videoPembahasanBtn = BattleContohView(
        title: "Video Pembahasan",
        image: "",
        selected: .notSelected
    )
    private lazy var pembahasanSingkatBtn = BattleContohView(
        title: "Pembahasan Singkat",
        image: "",
        selected: .notSelected
    )

    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background7")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var pembahasanTextWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.uiDelegate = self
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.isHidden = true
        return view
    }()
    
    private lazy var videoPlayerWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.uiDelegate = self
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private lazy var pembahasanBG: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.kobarBorderGray.cgColor
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.addSubview(pembahasanTextWebView)
        view.addSubview(videoPlayerWebView)
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
        stackView.alignment = .bottom
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
        
        if let url = URL(string: reviewVideoURL) {
            let request = URLRequest(url: url)
            videoPlayerWebView.load(request)
        }
        
        pembahasanTextWebView.loadHTMLString(reviewText, baseURL: nil)
    }
    
    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.bottom.trailing.leading.top.equalToSuperview()
        }
        pembahasanBG.snp.makeConstraints { make in
            make.width.equalTo(pembahasanSV).offset(10)
            make.centerX.equalTo(pembahasanSV)
            make.bottom.equalTo(kodingan)
            make.height.equalTo(535)
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
        pembahasanTextWebView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    private func setupComponents() {
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalToSuperview().offset(40)
        }
        kodingan.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.top.equalTo(descLabel.snp.bottom).offset(50)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.bottom.equalToSuperview().offset(-40)
        }
        pembahasanSV.snp.makeConstraints { make in
            make.bottom.equalTo(pembahasanBG.snp.top).offset(-10)
            make.leading.equalTo(kodingan.snp.trailing).offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        videoPlayerWebView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    private func buttonFunction() {
        videoPembahasanBtn.addAction(
            UIAction { [self] _ in
                videoPembahasanBtn.isItSelected = .selected
                pembahasanSingkatBtn.isItSelected = .notSelected
                animationLayout()
                UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                    self.pembahasanTextWebView.isHidden = true
                    self.videoPlayerWebView.isHidden = false
                }.startAnimation()
            },
            for: .touchUpInside
        )
        pembahasanSingkatBtn.addAction(
            UIAction { [self] _ in
                videoPembahasanBtn.isItSelected = .notSelected
                pembahasanSingkatBtn.isItSelected = .selected
                animationLayout()
                UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                    self.pembahasanTextWebView.isHidden = false
                    self.videoPlayerWebView.isHidden = true
                }.startAnimation()
            },
            for: .touchUpInside
        )
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
