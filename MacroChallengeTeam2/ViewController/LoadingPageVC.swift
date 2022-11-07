//
//  LoadingPageVC.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 07/11/22.
//

import UIKit
import Lottie

class LoadingPageVC: UIViewController {
    private lazy var background: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background1")
        return view
    }()

    private lazy var loadingGIF: LottieAnimationView = {
        let jsonName = "LandingScreenKobar"
        let animation = LottieAnimation.named(jsonName)
        let gif = LottieAnimationView(animation: animation)
        gif.contentMode = .scaleAspectFit
        gif.loopMode = .loop
        gif.play()
        return gif
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(loadingGIF)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        background.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }

        loadingGIF.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
