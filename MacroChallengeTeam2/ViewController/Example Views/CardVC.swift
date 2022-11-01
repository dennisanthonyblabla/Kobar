//
//  CardViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 24/10/22.
//

import UIKit
import SwiftUI
import SnapKit

class CardViewController: UIViewController {

    private lazy var textView = CardView(type: .outputCard)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(textView)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-500)
            make.height.equalToSuperview().offset(-200)
            make.center.equalToSuperview()
        }
    }

}

struct CardViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return CardViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }

}
