//
//  SmallButtonViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 01/11/22.
//

import UIKit
import SnapKit
import SwiftUI

class SmallButtonViewController: UIViewController {
    private lazy var smallButton = SmallButtonView(
        variant: .variant1,
        title: "Button")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(smallButton)
        setupAutoLayout()
        smallButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
    }

    private func setupAutoLayout() {
        smallButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.center.equalToSuperview()
        }
    }

    @objc func clickBack() {
        print("Clicked")
    }
}

struct SmallButtonViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return SmallButtonViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
