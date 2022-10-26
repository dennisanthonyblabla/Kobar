//
//  MainPageViewController.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 26/10/22.
//

import UIKit
import SnapKit
import SwiftUI

class MainPageViewController: UIViewController {

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var backgroundMotives: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "pageTandingYukBG")
        return view
    }()

    private lazy var tandingYukTitle: UILabel = {
        let label = UILabel()
        label.text = "Tanding Yuk!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .bold34
        return label
    }()

    private lazy var tandingYukDesc: UILabel = {
        let label = UILabel()
        label.text = "Uji Kemampuan koding lo dengan cus pilih lawan lo!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .regular28
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(tandingYukTitle)
        view.addSubview(tandingYukDesc)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        background.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(50)
            make.center.equalToSuperview()
        }
        backgroundMotives.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }

        tandingYukTitle.snp.makeConstraints { (make) in
            make.width.equalTo(tandingYukTitle.snp.width)
            make.height.equalTo(tandingYukTitle.snp.height)
            make.centerY.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
        }

        tandingYukDesc.snp.makeConstraints { (make) in
            make.width.equalTo(tandingYukDesc.snp.width)
            make.height.equalTo(tandingYukDesc.snp.height)
            make.top.equalTo(tandingYukTitle.snp.bottom).offset(15)
            make.centerX.equalTo(tandingYukTitle)
        }
    }
}

struct MainPageViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return MainPageViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
