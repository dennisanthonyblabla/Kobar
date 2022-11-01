//
//  TungguLawanVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 01/11/22.
//

import UIKit
import SnapKit
import SwiftUI
import Lottie

class TungguLawanViewController: UIViewController {

    private var seconds = 90
    private var timer = Timer()
    private var isTimerRunning = false

    private lazy var tandingBaruBtn = MedbuttonView(variant: .fixedWidth, title: "Tanding Baru")
    private lazy var pembahasanBtn = MedbuttonView(variant: .fixedWidth, title: "Pembahasan")

    private var timerLabel: UILabel = {
        let timer = UILabel()
//        timer.text = "01:30"
        timer.font = .bold38
        timer.textColor = .white
        return timer
    }()

    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarBlueBG
        return view
    }()

    private lazy var backgroundMotives: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "pageTungguLawanBG")
        return view
    }()

    private lazy var pantun: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        let isiPantun = NSAttributedString(
            string: "Ada cicak di dinding\nKenceng bunyinya\nCepet banget lo ngoding\nSabar nunggu lawan lo kelar ya"
        ).withLineSpacing(3)
        label.attributedText = isiPantun
        label.font = .semi28
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var desc: UILabel = {
        let label = UILabel()
        label.text = "Lawan lo kelar sekitar..."
        label.textColor = .white
        label.font = .regular22
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(backgroundMotives)
        view.addSubview(tandingBaruBtn)
        view.addSubview(pembahasanBtn)
        view.addSubview(pantun)
        view.addSubview(desc)
        view.addSubview(timerLabel)

        setupBackground()
        setupDisplays()
        setupComponents()
        runTimer()
    }

    private func setupBackground() {
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
    }

    private func setupDisplays() {
        pantun.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
        }
        desc.snp.makeConstraints { make in
            make.centerX.equalTo(pantun)
            make.top.equalTo(pantun.snp.bottom).offset(19)
        }
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(desc)
            make.top.equalTo(desc.snp.bottom).offset(2)
        }
    }

    private func setupComponents() {
        tandingBaruBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-170)
            make.bottom.equalToSuperview().offset(-100)
        }
        pembahasanBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(170)
            make.bottom.equalToSuperview().offset(-100)
        }
    }

    private func runTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(TungguLawanViewController.updateTimer),
            userInfo: nil,
            repeats: true)
    }

    @objc func updateTimer() {
        seconds -= 1
        if seconds == 0 {
            timer.invalidate()
        }
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }

    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let formatter = DateComponentsFormatter()
        return formatter.string(from: time) ?? "00"
    }
}

struct TungguLawanViewControllerPreviews: PreviewProvider {

    static var previews: some View {
        UIViewControllerPreview {
            return TungguLawanViewController()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
