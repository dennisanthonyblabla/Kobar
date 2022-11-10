//
//  RuangTungguViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 01/11/22.
//

import UIKit
import SnapKit
import SwiftUI

class InviteFriendPageViewController: UIViewController {
    var onBack: (() -> Void)?
    var onShowDiscussion: (() -> Void)?
    
    var user: User = .empty()
    var inviteCode: String = ""
    
    private lazy var profileUser: ProfileTandingView = {
        let view = ProfileTandingView(
            role: .user,
            name: user.nickname,
            rating: user.rating,
            imageURL: URL(string: user.picture))
        
        return view
    }()

    private lazy var profileInvite: ProfileInviteView = {
        ProfileInviteView(inviteCode: inviteCode)
    }()
    
    private lazy var shareBtn = SmallButtonView(variant: .variant2, title: "Bagikan", btnType: .share)
    
    private lazy var backBtn: SmallIconButtonView = {
        let button = SmallIconButtonView(variant: .variant2)
        
        button.addAction(
            UIAction { _ in
                self.onBack?()
            },
            for: .touchDown)
        
        return button
    }()

    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Ajak Teman"
        label.textColor = .white
        label.font = .bold34
        return label
    }()

    private lazy var swordVS: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "swordVS")
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

    private lazy var eloDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let desc = NSAttributedString(
            string: "Penilaian menggunakan ELO sistem. Pemain dengan rating lebih rendah (A) menang dari" + "\n"
            + "pemain rating lebih tinggi (B), maka pemain A "
            + "mendapatkan penambahan nilai sedangkan pemain B akan mendapatkan" + "\n"
            + "pengurangan nilai dengan nilai yang sama. Pemain dengan rating lebih rendah (A)"
            + " kalah dari pemain rating lebih tinggi (B)," + "\n"
            + " maka pemain A tidak mendapatkan pengurangan nilai sedangkan "
            + "pemain B mendapatkan penambahan nilai yang sedikit."
        ).withLineSpacing(3)
        label.attributedText = desc
        label.textColor = .white
        label.font = .semi17
        label.textAlignment = .center
        return label
    }()

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var backgroundMotives: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "background2")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(backBtn)
        view.addSubview(pageTitle)
        view.addSubview(pageDesc)
        view.addSubview(profileUser)
        view.addSubview(profileInvite)
        view.addSubview(swordVS)
        view.addSubview(eloDesc)
        view.addSubview(shareBtn)
        setupBackground()
        setupDisplays()
        setupComponents()
        shareBtn.addTarget(self, action: #selector(share), for: .touchUpInside)
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
        pageTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
        }
        pageDesc.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pageTitle.snp.bottom).offset(58)
        }
        swordVS.snp.makeConstraints { make in
            make.width.equalTo(swordVS)
            make.height.equalTo(swordVS)
            make.center.equalToSuperview()
        }
        eloDesc.snp.makeConstraints { make in
            make.width.height.equalTo(eloDesc)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
        }
    }

    private func setupComponents() {
        backBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(86)
            make.top.equalToSuperview().offset(70)
        }
        profileUser.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(300)
            make.centerY.equalToSuperview()
        }
        profileInvite.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-300)
            make.centerY.equalToSuperview()
        }
        shareBtn.snp.makeConstraints { make in
            make.centerX.equalTo(profileInvite).offset(10)
            make.bottom.equalTo(profileInvite).offset(110)
        }
    }

    @objc func share() {
        print("Clicked")
    }
}

struct RuangTungguViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return InviteFriendPageViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
