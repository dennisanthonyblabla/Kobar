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
    private var imageURL: URL?
    private var rating: Int?

    private lazy var profilePicture: UIImageView = {
        let imageView = UIImageView()
        
        imageView.load(from: imageURL, fallback: UIImage(named: "profilePicture"))
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 31.5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        return imageView
    }()

    private lazy var backCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarLightBlue
        view.layer.cornerRadius = 31.5
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
        view.layer.cornerRadius = 22.5
        view.addSubview(ratingStar)
        view.addSubview(ratingLabel)
        return view
    }()

    private lazy var bannerBackBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kobarLightBlue
        view.layer.cornerRadius = 22.5
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(rating: Int, imageURL: URL? = nil) {
        super.init(frame: .zero)
        self.rating = rating
        self.imageURL = imageURL
        addSubview(bannerBackBG)
        addSubview(bannerFrontBG)
        addSubview(backCircle)
        addSubview(profilePicture)
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {
        let circleHeight = 63

        backCircle.snp.makeConstraints { make in
            make.height.equalTo(circleHeight)
            make.width.equalTo(circleHeight)
            make.top.equalTo(profilePicture).offset(4)
            make.centerX.equalTo(profilePicture)
        }
        profilePicture.snp.makeConstraints { make in
            make.width.equalTo(circleHeight)
            make.height.equalTo(circleHeight)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        bannerFrontBG.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(45)
            make.centerY.equalTo(profilePicture)
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
