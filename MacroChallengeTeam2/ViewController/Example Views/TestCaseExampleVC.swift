//
//  TestCaseViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 24/10/22.
//

import UIKit
import SwiftUI
import SnapKit

class TestCaseExampleViewController: UIViewController {
    private lazy var testCaseView = TestCaseButton(style: .fill, status: .correct, order: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(testCaseView)
        testCaseView.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        testCaseView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(testCaseView.snp.height)
            make.width.equalTo(testCaseView.snp.width)
        }
    }

    @objc func clickBack() {
        print("Clicked")
    }
}

struct TestCaseExampleViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return TestCaseExampleViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeRight)
    }
}
