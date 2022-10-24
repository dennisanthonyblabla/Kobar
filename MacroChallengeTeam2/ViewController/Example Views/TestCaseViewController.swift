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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }

    private func setupAutoLayout() {

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
