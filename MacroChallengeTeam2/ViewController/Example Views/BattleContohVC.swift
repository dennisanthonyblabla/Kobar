//
//  MPContohVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 03/11/22.
//

import UIKit
import SwiftUI
import SnapKit

class BattleContohViewController: UIViewController {
    private lazy var contoh1 = BattleContohView(title: "Contoh (1)")
    private var exampleCount = 3
    private lazy var examples: [BattleContohView] = {
        var contoh: [BattleContohView] = []
        for i in 1...exampleCount {
            contoh.append(BattleContohView(title: "contoh " + "(\(i))"))
        }
        return contoh
    }()

    private lazy var svContoh: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: examples)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(svContoh)

        setupAutoLayout()
    }

    private func setupAutoLayout() {
        svContoh.snp.makeConstraints { make in
            make.width.equalTo(500)
            make.height.equalTo(100)
            make.center.equalToSuperview()
        }
//        examples[0].snp.makeConstraints { make in
//            make.top.equalTo(contoh1.snp.bottom)
//            make.centerX.equalToSuperview()
//        }
//        examples[1].snp.makeConstraints { make in
//            make.top.equalTo(examples[0].snp.bottom)
//            make.centerX.equalToSuperview()
//        }
    }
}

struct MPContohViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return BattleContohViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
