//
//  ViewController.swift
//  MacroChallengeTeam2
//
//  Created by Dennis Anthony on 06/10/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}

struct ViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return ViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
    }
}
