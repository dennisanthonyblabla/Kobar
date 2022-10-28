//
//  DropdownButtonViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 27/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class DropdownButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupAutoLayout()
        // Do any additional setup after loading the view.
    }

    private func setupAutoLayout() {

    }
}

struct DropdownButtonViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return DropdownButtonViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeRight)
    }
}
