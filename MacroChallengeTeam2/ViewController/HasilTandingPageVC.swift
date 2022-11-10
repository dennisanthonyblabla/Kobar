//
//  HasilTandingPageVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 10/11/22.
//

import UIKit
import SwiftUI
import SnapKit
import RxSwift
import Lottie

class HasilTandingPageViewController: UIViewController {
    private var userWin = false
    private lazy var udahanDehBtn = MedButtonView(variant: .variant2, title: "Udahan Deh")
    private lazy var pembahasanBtn = MedButtonView(variant: .variant2, title: "Pembahasan")

    private lazy var userProfile = ProfileTandingView(
        role: .user,
        name: "John Doe",
        rating: 32,
        state: "+"
    )

    private lazy var opponentProfile = ProfileTandingView(
        role: .opponent,
        name: "Jane Doe",
        rating: 32,
        state: "-"
    )

    private lazy var background: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background6")
        return view
    }()

    private lazy var swordVS: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "swordVSActive")
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hasil Tanding"
        label.textColor = .white
        label.font = .bold34
        label.textAlignment = .center
        return label
    }()

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .medium28
        label.textAlignment = .center
        return label
    }()

    private lazy var kebenaranKodeBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarDarkBlueBG
        view.layer.cornerRadius = 25
        view.addSubview(kebenaranLabelSV)
        return view
    }()

    private lazy var kinerjaKodeBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarDarkBlueBG
        view.layer.cornerRadius = 25
        view.addSubview(kinerjaLabelSV)
        return view
    }()

    private lazy var kecepatanWaktuBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarDarkBlueBG
        view.layer.cornerRadius = 25
        view.addSubview(kecepatanLabelSV)
        return view
    }()

    private lazy var summarySV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kebenaranKodeBG, kinerjaKodeBG, kecepatanWaktuBG])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    private lazy var kebenaranLabel: UILabel = {
        let label = UILabel()
        label.text = "Kebenaran Kode"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var kinerjaLabel: UILabel = {
        let label = UILabel()
        label.text = "Kinerja Kode"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var kecepatanLabel: UILabel = {
        let label = UILabel()
        label.text = "Kecepatan Waktu"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var userKebenaranRateLabel: UILabel = {
        let label = UILabel()
        label.text = "2/3"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var opponentKebenaranRateLabel: UILabel = {
        let label = UILabel()
        label.text = "1/3"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var userKinerjaLabel: UILabel = {
        let label = UILabel()
        label.text = "5 ms"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var opponentKinerjaLabel: UILabel = {
        let label = UILabel()
        label.text = "20ms"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var userKecepatanLabel: UILabel = {
        let label = UILabel()
        label.text = "05:30"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var opponentKecepatanLabel: UILabel = {
        let label = UILabel()
        label.text = "07:38"
        label.textColor = .white
        label.font = .medium17
        label.textAlignment = .center
        return label
    }()

    private lazy var kebenaranLabelSV: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                userKebenaranRateLabel,
                kebenaranLabel,
                opponentKebenaranRateLabel
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var kinerjaLabelSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userKinerjaLabel, kinerjaLabel, opponentKinerjaLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var kecepatanLabelSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userKecepatanLabel, kecepatanLabel, opponentKecepatanLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var crown: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "crown")
        view.alpha = 0
        return view
    }()

    private lazy var confettiGif: LottieAnimationView = {
        let jsonName = "Confetti"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        return gif
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kobarBlueBG
        view.addSubview(background)
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(userProfile)
        view.addSubview(opponentProfile)
        view.addSubview(swordVS)
        view.addSubview(kebenaranKodeBG)
        view.addSubview(summarySV)
        view.addSubview(udahanDehBtn)
        view.addSubview(pembahasanBtn)

        setupBackground()
        setupDisplays()
        setupComponents()
        checkIfUserWin()
    }
}

extension HasilTandingPageViewController {
    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        summarySV.snp.makeConstraints { make in
            make.top.equalTo(swordVS.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        kebenaranKodeBG.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        kinerjaKodeBG.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        kecepatanWaktuBG.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func setupDisplays() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
        }
        swordVS.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(30)
        }
        kebenaranLabelSV.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        kinerjaLabelSV.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        kecepatanLabelSV.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    private func setupComponents() {
        userProfile.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(150)
            make.leading.equalToSuperview().offset(300)
        }
        opponentProfile.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(150)
            make.trailing.equalToSuperview().offset(-300)
        }
        udahanDehBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalTo(view.snp.centerX).multipliedBy(0.94)
            make.width.equalTo(200)
        }
        pembahasanBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view.snp.centerX).multipliedBy(1.06)
            make.width.equalTo(200)
        }
    }

    private func checkIfUserWin() {
        if userWin == true {
            self.view.addSubview(crown)
            self.view.addSubview(confettiGif)
            self.descLabel.text = "Keren lo menang Coy!\nMantep banget!"

            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 1.2,
                delay: 1.5,
                options: .curveEaseOut,
                animations: {
                    self.crown.alpha = 1
                },
                completion: nil
            )

            crown.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.2)
                make.height.equalTo(crown.snp.width)
                make.bottom.equalTo(userProfile.snp.top).offset(-5)
                make.trailing.equalTo(userProfile.snp.centerX).offset(10)
            }
            ProfileTandingView.animate(withDuration: 0.7, delay: 1) {
                self.userProfile.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }
            confettiGif.snp.makeConstraints { make in
                make.width.height.equalToSuperview()
                make.center.equalToSuperview()
            }
            confettiGif.play()
        } else {
            self.view.addSubview(crown)
            let flippedCrown = UIImage(named: "crown")?.withHorizontallyFlippedOrientation()
            self.crown.image = flippedCrown
            self.descLabel.text = "Kalah itu biasa! Yang penting ada hal\nbaru yang didapet. Semangat!!"

            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 1.2,
                delay: 1.5,
                options: .curveEaseOut,
                animations: {
                    self.crown.alpha = 1
                },
                completion: nil
            )

            ProfileTandingView.animate(withDuration: 0.7, delay: 1) {
                self.opponentProfile.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            }

            crown.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.2)
                make.height.equalTo(crown.snp.width)
                make.bottom.equalTo(opponentProfile.snp.top).offset(-5)
                make.leading.equalTo(opponentProfile.snp.centerX).offset(-5)
            }
        }
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

struct HasilTandingPageViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: HasilTandingPageViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}