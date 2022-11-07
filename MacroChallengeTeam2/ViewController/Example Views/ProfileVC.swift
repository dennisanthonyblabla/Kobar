//
//  ProfileViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 26/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class ProfileViewController: UIViewController {
    private lazy var profileUser = ProfileTandingView(role: .user, name: "Benny", rating: 256)
    private lazy var profileInvite = ProfileInviteView(inviteCode: "2A54D")

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(profileUser)
        view.addSubview(profileInvite)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        background.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(50)
        }

        profileUser.snp.makeConstraints { make in
            make.width.equalTo(profileUser.snp.width)
            make.height.equalTo(profileUser.snp.height)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-200)
        }

        profileInvite.snp.makeConstraints { make in
            make.width.equalTo(profileInvite.snp.width)
            make.height.equalTo(profileInvite.snp.height)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(200)
        }
    }
}

struct ProfileViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return ProfileViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
