//
//  ShortProfileView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 31/10/22.
//

import Foundation
import UIKit
import SnapKit

final class ShortProfileView: UIView {

    private var rating: Int?

    private lazy var frontCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var backCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarLightBlue
        return view
    }()

    private lazy var ratingStar: UIImageView = {
        let imageView = UIImageView()
        var ratingStar = UIImage(named: "ratingStarSmall")
        imageView.image = ratingStar
        return imageView
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = String(rating ?? 00)
        label.textAlignment = .right
        label.textColor = .kobarBlueActive
        label.font = .semi22
        return label
    }()

    private lazy var bannerFrontBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(ratingStar)
        view.addSubview(ratingLabel)
        return view
    }()

    private lazy var bannerBackBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarLightBlue
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(rating: Int) {
        super.init(frame: .zero)
        self.rating = rating
        addSubview(bannerBackBG)
        addSubview(bannerFrontBG)
        addSubview(backCircle)
        addSubview(frontCircle)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {
        let circleHeight = 63
        let labelHeight = 45
        self.bannerFrontBG.layer.cornerRadius = CGFloat(labelHeight / 2)
        self.bannerBackBG.layer.cornerRadius = CGFloat(labelHeight / 2)
        self.frontCircle.layer.cornerRadius = CGFloat(circleHeight / 2)
        self.backCircle.layer.cornerRadius = CGFloat(circleHeight / 2)

        frontCircle.snp.makeConstraints { make in
            make.height.equalTo(circleHeight)
            make.width.equalTo(circleHeight)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        backCircle.snp.makeConstraints { make in
            make.height.equalTo(frontCircle)
            make.width.equalTo(frontCircle)
            make.top.equalTo(frontCircle).offset(4)
            make.centerX.equalTo(frontCircle)
        }
        bannerFrontBG.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(labelHeight)
            make.centerY.equalTo(frontCircle)
            make.leading.equalToSuperview().offset(21.5)
        }
        bannerBackBG.snp.makeConstraints { make in
            make.width.equalTo(bannerFrontBG)
            make.height.equalTo(bannerFrontBG)
            make.centerX.equalTo(bannerFrontBG)
            make.centerY.equalTo(bannerFrontBG).offset(4)
        }
        ratingLabel.snp.makeConstraints { make in
            make.width.equalTo(ratingLabel)
            make.height.equalTo(ratingLabel)
            make.trailing.equalToSuperview().offset(-27)
            make.centerY.equalToSuperview()
        }
        ratingStar.snp.makeConstraints { make in
            make.width.equalTo(ratingStar.snp.width)
            make.height.equalTo(ratingStar.snp.height)
            make.leading.equalToSuperview().offset(50)
            make.centerY.equalToSuperview()
        }
    }
}
