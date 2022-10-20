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
    private lazy var smallBackButton: SmallBackButtonView = {
        let btn = SmallBackButtonView()
        btn.variant = .variant2
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(smallBackButton)
        setupAutoLayout()
        addActionToButton()
    }
    private func setupAutoLayout() {
        smallBackButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    func addActionToButton() {
        smallBackButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
    }
    @objc func clickBack() {
        print("Clicked")
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
