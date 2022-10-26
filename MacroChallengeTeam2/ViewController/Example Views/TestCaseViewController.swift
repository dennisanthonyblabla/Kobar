//
//  TestCaseViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 24/10/22.
//

import UIKit
import SwiftUI
import SnapKit

class TestCaseViewController: UIViewController {

    private lazy var testCaseView = TestCaseButton(style: .transparent, status: .correct, order: 5)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(testCaseView)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        testCaseView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(testCaseView.snp.height)
            make.width.equalTo(testCaseView.snp.width)
        }
    }
}

struct TestCaseViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return TestCaseViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeRight)
    }
}
