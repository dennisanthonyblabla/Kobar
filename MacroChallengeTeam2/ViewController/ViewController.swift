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
    private lazy var textView: CardView = {
        let view = CardView()
//        view.title = "Titlenya"
        view.cardType = .inputCard
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(textView)
        setupAutoLayout()
        smallBackButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
    }
    private func setupAutoLayout() {
        textView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-500)
            make.height.equalToSuperview().offset(-200)
            make.center.equalToSuperview()
        }
    }

    // TODO: add behavior
    @objc func clickBack() {
        print("Clicked")
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
