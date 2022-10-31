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

    private lazy var ddBG: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32.5
        view.alpha = 0.5
        return view
    }()

    private lazy var settingBtn = DropDownButtonsView(variant: .variant1)
    private lazy var soundBtn = DropDownButtonsView(variant: .variant2)
    private lazy var musicBtn = DropDownButtonsView(variant: .variant3)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(ddBG)
        view.addSubview(settingBtn)
        view.addSubview(soundBtn)
        view.addSubview(musicBtn)

        settingBtn.addTarget(self, action: #selector(settingFunc), for: .touchUpInside)
        soundBtn.addTarget(self, action: #selector(soundFunc), for: .touchUpInside)
        musicBtn.addTarget(self, action: #selector(musicFunc), for: .touchUpInside)
        setupAutoLayout()
    }

    private func setupAutoLayout() {
        ddBG.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(202)
            make.center.equalToSuperview()
        }
        settingBtn.snp.makeConstraints { make in
            make.centerX.equalTo(ddBG)
            make.centerY.equalTo(ddBG.snp.top).offset(33)
        }
        soundBtn.snp.makeConstraints { make in
            make.centerX.equalTo(ddBG)
            make.top.equalTo(settingBtn.snp.bottom).offset(25.5)
        }
        musicBtn.snp.makeConstraints { make in
            make.centerX.equalTo(ddBG)
            make.top.equalTo(soundBtn.snp.bottom).offset(25.5)
        }
    }

    @objc func settingFunc() {
        print("ToDoSetting")
    }

    @objc func soundFunc() {
        print("ToDoSound")
    }

    @objc func musicFunc() {
        print("ToDoMusic")
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
