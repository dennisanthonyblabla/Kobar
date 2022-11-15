//
//  DokumentasiVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 10/11/22.
//

import UIKit
import SwiftUI

class DokumentasiViewController: UIViewController {
    private lazy var dokumentasi: DokumentasiView = {
        let view = DokumentasiView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kobarBlueBG
        view.addSubview(dokumentasi)

        setupAutoLayout()
    }

    private func setupAutoLayout() {
        dokumentasi.snp.makeConstraints { make in
            make.width.equalTo(dokumentasi.snp.width)
            make.height.equalTo(dokumentasi.snp.height)
            make.center.equalToSuperview()
        }
    }
}

struct DokumentasiViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: DokumentasiViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
