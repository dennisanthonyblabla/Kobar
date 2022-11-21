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
    private var chosen: Bool?
    private var exampleCount = 3
    private lazy var examples: [BattleContohView] = {
        var currentBtn: Int?
        var previousBtn: Int?
        var contoh: [BattleContohView] = []
        for i in 1...exampleCount {
            contoh.append(BattleContohView(title: "contoh " + "(\(i))", image: "chevron.down", selected: .notSelected))
        }
        for (index, i) in contoh.enumerated() {
            i.addAction(
                UIAction { [self]_ in
                    currentBtn = index
                    for each in contoh {
                        each.isItSelected = .notSelected
                    }
                    if currentBtn == previousBtn {
                        i.isItSelected = .notSelected
                        currentBtn = nil
                    } else {
                        i.isItSelected = .selected
                    }
                    previousBtn = currentBtn
                }, for: .touchDown)
        }

        return contoh
    }()

    private lazy var svContoh: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: examples)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .bottom
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
            make.height.equalTo(svContoh.snp.height)
            make.center.equalToSuperview()
        }
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
