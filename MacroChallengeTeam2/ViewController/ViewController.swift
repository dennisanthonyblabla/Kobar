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

    private lazy var profileTanding: ProfileTandingView = {
        let view = ProfileTandingView()
        view.role = .user
        view.name = "User"
        view.rating = 256
        return view
    }()

    private lazy var profileInvite: ProfileInvite = {
        let view = ProfileInvite()
        view.inviteCode = "3A47D"
        return view
    }()

    private lazy var testCase = TestCaseButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }

}
struct ViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return ViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
