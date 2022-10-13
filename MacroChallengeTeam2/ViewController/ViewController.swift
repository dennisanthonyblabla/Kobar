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
    private lazy var profileTanding: ProfileTanding = {
        let view = ProfileTanding()
        view.role = .opponent
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "kobarGray")
        view.addSubview(profileTanding)
        setupAutoLayout()
    }
    private func setupAutoLayout() {
        profileTanding.snp.makeConstraints { (make) in
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
