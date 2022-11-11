//
//  ReadyForBattlePageViewController.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import SnapKit

// TODO: @salman update opponent profile when they left
class ReadyForBattlePageViewController: UIViewController {
    var onBack: (() -> Void)?
    var onReady: (() -> Void)?
    var onCountdownFinished: (() -> Void)?
    
    var user: User = .empty()
    var opponent: User = .empty()
    var battleStartDate: Date?
    
    private lazy var userProfileTandingView: ProfileTandingView = {
        let view = ProfileTandingView(
            role: .user,
            name: user.nickname,
            rating: user.rating,
            imageURL: URL(string: user.picture))
        
        return view
    }()

    private lazy var opponentProfileTandingView: ProfileTandingView = {
        let view = ProfileTandingView(
            role: .opponent,
            name: opponent.nickname,
            rating: opponent.rating,
            imageURL: URL(string: opponent.picture))
        
        return view
    }()
    
    private lazy var backButtonView: SmallIconButtonView = {
        let button = SmallIconButtonView(variant: .variant2)
        button.addVoidAction(onBack, for: .touchDown)
        return button
    }()
    
    private lazy var readyButtonView: MedButtonView = {
        let button = MedButtonView(variant: .variant2, title: "Mulai")
        button.addAction(
            UIAction { [self] _ in
                updateButton()
                self.onReady?()
            }, for: .touchDown)
        return button
    }()
    
    private lazy var waitButtonView: MedButtonView = {
        let button = MedButtonView(variant: .variant3, title: "Tunggu Lawan")
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
        view.contentMode = .scaleAspectFill
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
            make.height.width.equalToSuperview()
        }
    }

    private func setupDisplaysConstraint() {
        pageTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
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
            make.bottom.equalToSuperview().offset(-50)
        }
        countdownLabel.snp.makeConstraints { make in
            make.top.equalTo(promptLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func setupComponentsConstraint() {
        backButtonView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(86)
            make.top.equalToSuperview().offset(70)
        }
        userProfileTandingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(300)
            make.centerY.equalToSuperview()
        }
        opponentProfileTandingView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-300)
            make.centerY.equalToSuperview()
        }
        readyButtonView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.snp.bottom).multipliedBy(0.77)
            make.width.equalTo(160)
        }
        waitButtonView.snp.makeConstraints { make in
            make.height.centerX.centerY.equalTo(readyButtonView)
        }
    }
}
