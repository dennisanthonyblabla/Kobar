//
//  SignInVC.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 04/11/22.
//

import UIKit
import SwiftUI
import SnapKit
import Lottie

class SignInViewController: UIViewController {

    var onSignIn: (() -> Void)?
    var onSignUp: (() -> Void)?

    private lazy var background: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background1")
        return view
    }()

    private lazy var signInDoorGIF: LottieAnimationView = {
        let jsonName = "SignInDoor"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        return gif
    }()

    private lazy var signInButton: MedButtonView = {
        let button = MedButtonView(variant: .variant2, title: "􀣺 Masuk dengan Apple")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction { _ in
                self.onSignIn?()
            },
            for: .touchDown)
        return button
    }()

    private lazy var signUpButton: MedButtonView = {
        let button = MedButtonView(variant: .variant2, title: "􀣺 Daftar dengan Apple")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction { _ in
                self.onSignUp?()
            },
            for: .touchDown)
        return button
    }()

    private lazy var daftarYukLabel: UILabel = {
        let label = UILabel()
        label.text = "Daftar yuk kalau belom punya akun!"
        label.font = .regular17
        label.textColor = .white
        return label
    }()

    private lazy var asikinAjaLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Yuk masuk untuk\nlanjutin akun lo!",
            attributes: [
                .font: UIFont.bold34 ?? UIFont.systemFont(ofSize: 34)
            ]
        ).withLineSpacing(8)

        label.attributedText = text
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    // TODO: refactor to a new component
    private lazy var atauView: UIView = {
        let view = UIView()

        let leftLine = UIView()
        leftLine.backgroundColor = .white

        let label = UILabel()
        label.text = "Atau"
        label.font = .regular17
        label.textColor = .white

        let rightLine = UIView()
        rightLine.backgroundColor = .white

        view.addSubview(leftLine)
        view.addSubview(label)
        view.addSubview(rightLine)

        leftLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(view)
            make.right.equalTo(label.snp.left).offset(-10)
            make.centerY.equalTo(view)
        }

        rightLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(leftLine)
            make.left.equalTo(label.snp.right).offset(10)
            make.right.equalTo(view)
            make.centerY.equalTo(view)
        }

        label.snp.makeConstraints { make in
            make.bottom.top.equalTo(view)
        }

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(background)
        view.addSubview(signUpButton)
        view.addSubview(daftarYukLabel)
        view.addSubview(atauView)
        view.addSubview(signInButton)
        view.addSubview(asikinAjaLabel)
        view.addSubview(signInDoorGIF)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide.snp
        let bottomPadding = -90

        background.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }

        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea.bottom).offset(bottomPadding)
            make.centerX.equalToSuperview()
        }

        daftarYukLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-12)
            make.centerX.equalToSuperview()
        }

        atauView.snp.makeConstraints { make in
            make.bottom.equalTo(daftarYukLabel.snp.top).offset(-12)
            make.width.equalTo(signUpButton)
            make.centerX.equalToSuperview()
        }

        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(atauView.snp.top).offset(-12)
            make.centerX.equalToSuperview()
        }

        asikinAjaLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-18)
            make.centerX.equalToSuperview()
        }

        signInDoorGIF.snp.makeConstraints { make in
            make.bottom.equalTo(atauView.snp.top).offset(-75)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(500)
        }
    }
}

struct SignInViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return SignInViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
