//
//  ShortProfileViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 31/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class ShortProfileViewController: UIViewController {

    private lazy var profile = ShortProfileView(rating: 2000)

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(profile)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        background.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(50)
        }
        profile.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

struct ShortProfileViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return ShortProfileViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }

}
