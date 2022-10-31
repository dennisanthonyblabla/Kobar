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

    private lazy var settingBtn = DropDownButtonsView(variant: .variant1)
    private lazy var soundBtn = DropDownButtonsView(variant: .variant2)
    private lazy var musicBtn = DropDownButtonsView(variant: .variant3)

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

    private lazy var swordGif: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Pedang - Home Screen.GIF")
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

    private lazy var ddBG: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 32.5
        view.alpha = 0.5
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(tandingYukTitle)
        view.addSubview(tandingYukDesc)
        view.addSubview(ddBG)
        view.addSubview(settingBtn)
        view.addSubview(soundBtn)
        view.addSubview(musicBtn)
        view.addSubview(swordGif)

        settingBtn.addTarget(self, action: #selector(settingFunc), for: .touchUpInside)
        soundBtn.addTarget(self, action: #selector(soundFunc), for: .touchUpInside)
        musicBtn.addTarget(self, action: #selector(musicFunc), for: .touchUpInside)
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
            make.centerY.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        tandingYukDesc.snp.makeConstraints { (make) in
            make.width.equalTo(tandingYukDesc.snp.width)
            make.height.equalTo(tandingYukDesc.snp.height)
            make.top.equalTo(tandingYukTitle.snp.bottom).offset(15)
            make.centerX.equalTo(tandingYukTitle)
        }
        swordGif.snp.makeConstraints { make in
            make.width.equalTo(580)
            make.height.equalTo(580)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-120)
        }
        ddBG.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(202)
            make.trailing.equalToSuperview().offset(-89)
            make.top.equalToSuperview().offset(70)
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

struct MainPageViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return MainPageViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
