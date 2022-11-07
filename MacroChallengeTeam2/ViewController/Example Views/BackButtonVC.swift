//
//  BackButtonViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 24/10/22.
//

import UIKit
import SwiftUI
import SnapKit

class BackButtonViewController: UIViewController {
    private lazy var smallBackButton = SmallBackButtonView(variant: .variant1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(smallBackButton)
        setupAutoLayout()
        smallBackButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
    }

    private func setupAutoLayout() {
        smallBackButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc func clickBack() {
        print("Clicked")
    }
}

struct BackButtonViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return BackButtonViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeRight)
    }
}
