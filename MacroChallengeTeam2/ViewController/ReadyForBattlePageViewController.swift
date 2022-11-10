//
//  ReadyForBattlePageViewController.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import SnapKit

class ReadyForBattlePageViewController: UIViewController {
    var onBack: (() -> Void)?
    var onReady: (() -> Void)?
    
    var user: User = .empty()
    var opponent: User = .empty()
    
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
        button.addVoidAction(onReady, for: .touchDown)
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

    private lazy var pageDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Ajak temen lo buat" + "\n" + "tanding sekarang!"
        label.textColor = .white
        label.font = .bold34
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
        view.addSubview(pageTitleLabel)
        view.addSubview(pageDesc)
        view.addSubview(userProfileTandingView)
        view.addSubview(opponentProfileTandingView)
        view.addSubview(swordVSImageView)
        view.addSubview(bottomTextLabel)
        
        
        setupBackgroundConstraints()
        setupDisplaysConstraint()
        setupComponentsConstraint()
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
        pageDesc.snp.makeConstraints { make in
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
    }
}