//
//  MedButtonViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 26/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class MedButtonViewController: UIViewController {

    private lazy var medButton = MedbuttonView(variant: .variant1, title: "Let's go")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(medButton)
        medButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        medButton.snp.makeConstraints { make in
            make.width.equalTo(medButton.snp.width)
            make.height.equalTo(medButton.snp.height)
            make.center.equalToSuperview()
        }
    }

    @objc func clickBack() {
        print("Clicked")
    }
}

struct MedButtonViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return MedButtonViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
