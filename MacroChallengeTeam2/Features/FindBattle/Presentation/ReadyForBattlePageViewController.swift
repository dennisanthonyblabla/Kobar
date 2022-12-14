//
//  ReadyForBattlePageViewController.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import SnapKit
import SwiftUI

class ReadyForBattlePageViewController: UIViewController {
    var onBack: (() -> Void)?
    var onReady: (() -> Void)?
    var onCountdownFinished: (() -> Void)?
    
    var userName: String = ""
    var userPicture: String = ""
    var userRating: Int = 0
    
    var opponentName: String = ""
    var opponentPicture: String = ""
    var opponentRating: Int = 0

    var battleStartDate: Date?
    
    private lazy var userProfileTandingView: ProfileTandingView = {
        let view = ProfileTandingView(
            role: .user,
            name: userName,
            rating: userRating,
            imageURL: URL(string: userPicture))
        
        return view
    }()

    private lazy var opponentProfileTandingView: ProfileTandingView = {
        let view = ProfileTandingView(
            role: .opponent,
            name: opponentName,
            rating: opponentRating,
            imageURL: URL(string: opponentPicture))
        
        return view
    }()
    
    private lazy var backButtonView: SmallIconButtonView = {
        let button = SmallIconButtonView(variant: .variant2)
        button.addVoidAction(onBack, for: .touchUpInside)
        return button
    }()
    
    private lazy var readyButtonView: MedButtonView = {
        let button = MedButtonView(variant: .variant2, title: "Mulai")
        button.addAction(
            UIAction { [self] _ in
                updateButton()
                self.onReady?()
            }, for: .touchUpInside)
        return button
    }()
    
    private lazy var waitButtonView: MedButtonView = {
        let button = MedButtonView(variant: .variant3, title: "Tunggu Lawan", isPressed: true)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()

    private lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Siap yee!"
        label.textColor = .white
        label.font = .bold34
        return label
    }()

    private lazy var swordVSImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "swordVSRed")
        return view
    }()

    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Tanding koding dimulai dalam..."
        label.textColor = .white
        label.font = .medium28
        return label
    }()
    
    private lazy var countdownLabel: CountdownLabelView = {
        let label = CountdownLabelView(endDate: battleStartDate)
        label.onCountdownFinished = onCountdownFinished
        label.numberOfLines = 1
        label.font = .bold38
        label.textColor = .white
        return label
    }()

    private lazy var bottomTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let desc = NSAttributedString(
            string: "Panas terik terasa\n"
            + "Kepala oleng rasanya\n"
            + "Lo pasti bisa\n"
            + "Semangat ngerjainnya"
        ).withLineSpacing(3)
        label.attributedText = desc
        label.textColor = .white
        label.font = .semi17
        label.textAlignment = .center
        return label
    }()

    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background2")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        view.addSubview(backButtonView)
        view.addSubview(readyButtonView)
        view.addSubview(waitButtonView)
        view.addSubview(pageTitleLabel)
        view.addSubview(promptLabel)
        view.addSubview(userProfileTandingView)
        view.addSubview(opponentProfileTandingView)
        view.addSubview(swordVSImageView)
        view.addSubview(bottomTextLabel)
        view.addSubview(countdownLabel)
        
        setupBackgroundConstraints()
        setupDisplaysConstraint()
        setupComponentsConstraint()
    }
    
    private func updateButton() {
        readyButtonView.isHidden = true
        waitButtonView.isHidden = false
    }

    private func setupBackgroundConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(15)
            make.height.equalToSuperview().offset(19)
            make.center.equalToSuperview()
        }
    }

    private func setupDisplaysConstraint() {
        pageTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.16)
        }
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(58)
        }
        swordVSImageView.snp.makeConstraints { make in
            make.width.equalTo(swordVSImageView)
            make.height.equalTo(swordVSImageView)
            make.center.equalToSuperview()
        }
        bottomTextLabel.snp.makeConstraints { make in
            make.width.height.equalTo(bottomTextLabel)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.8)
        }
        countdownLabel.snp.makeConstraints { make in
            make.top.equalTo(promptLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func setupComponentsConstraint() {
        backButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(0.18)
            make.centerY.equalToSuperview().multipliedBy(0.25)
        }
        userProfileTandingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(200)
            make.centerY.equalToSuperview()
        }
        opponentProfileTandingView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-200)
            make.centerY.equalToSuperview()
        }
        readyButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.snp.bottom).multipliedBy(0.77)
            make.width.equalTo(160)
        }
        waitButtonView.snp.makeConstraints { make in
            make.height.equalTo(readyButtonView)
            make.width.equalTo(160)
            make.center.equalTo(readyButtonView)
        }
    }
}

struct ReadyForBattlePageViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: ReadyForBattlePageViewController())
        }
        .previewDevice("iPad Pro (12.9-inch) (5th generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
