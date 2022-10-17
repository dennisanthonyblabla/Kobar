//
//  ViewController.swift
//  MacroChallengeTeam2
//
//  Created by Dennis Anthony on 06/10/22.
//

import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {
    private lazy var profileUser: ProfileTanding = {
        let view = ProfileTanding()
        view.role = .opponent
        view.name = "Michael"
        view.rating = 256
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.kobarGray
        view.addSubview(profileUser)
        setupAutoLayout()
    }
    private func setupAutoLayout() {
        profileUser.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return ViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeRight)
    }
}
