//
//  ProfileTanding.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 11/10/22.
//

import Foundation
import SnapKit
import UIKit

final class ProfileTanding: UIView {

    enum Role {
        case user
        case opponent
    }

    var role: Role = .user {
        didSet {
            switch role {
            case .user:
                self.profileBG.layer.borderColor = UIColor.kobarGreen.cgColor
                self.ratingHolder.backgroundColor = UIColor.kobarGreen
            case .opponent:
                self.profileBG.layer.borderColor = UIColor.kobarRed.cgColor
                self.ratingHolder.backgroundColor = UIColor.kobarRed
            }
        }
    }
    var name: String? {
        didSet {
            self.playerName.text = name
        }
    }
    var rating: Int? {
        didSet {
            self.ratingLabel.text = String(rating ?? 1)
        }
    }

    private lazy var playerName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .medium22
        label.text = name ?? "Player"
        return label
    }()
    private lazy var profileBG: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.kobarGreen.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.kobarGray
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 7
        return view
    }()
    private lazy var profileView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 128)
        let profile = UIImage(systemName: "person.fill", withConfiguration: config)
        imageView.image = profile?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        return imageView
    }()
     private lazy var ratingHolder: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = UIColor.kobarGreen
         view.layer.cornerRadius = 22
         view.addSubview(ratingStar)
         view.addSubview(ratingLabel)
         return view
     }()
    private lazy var ratingStar: UIImageView = {
        let imageView = UIImageView()
        var ratingStar = UIImage(named: "ratingStar")
        imageView.image = ratingStar
        return imageView
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .white
        label.font = .bold28
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileBG)
        addSubview(playerName)
        addSubview(profileView)
        addSubview(ratingHolder)
        setupAutoLayout()
    }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
     private func setupAutoLayout() {
         profileBG.snp.makeConstraints { (make) in
             make.width.equalTo(233)
             make.height.equalTo(205)
             make.center.equalToSuperview()
         }
         ratingHolder.snp.makeConstraints { (make) in
             make.width.equalTo(profileBG.snp.width).inset(36)
             make.height.equalTo(44)
             make.centerX.equalTo(profileBG)
             make.bottom.equalTo(profileBG).inset(-20)
         }
         ratingStar.snp.makeConstraints { (make) in
             make.width.equalTo(26.73)
             make.height.equalTo(25.61)
             make.leading.equalTo(ratingHolder.snp.leading).inset(20)
             make.centerY.equalToSuperview()
         }
         ratingLabel.snp.makeConstraints { (make) in
             make.width.equalTo(ratingLabel.snp.width)
             make.height.equalTo(ratingLabel.snp.height)
             make.trailing.equalTo(ratingHolder.snp.trailing).inset(20)
             make.centerY.equalToSuperview()
         }
         playerName.snp.makeConstraints { (make) in
             make.width.equalTo(playerName.snp.width)
             make.height.equalTo(playerName.snp.height)
             make.bottom.equalTo(profileBG.snp.top).inset(-18)
             make.centerX.equalToSuperview()
         }
         profileView.snp.makeConstraints { (make) in
             make.width.equalTo(profileView.snp.width)
             make.height.equalTo(profileView.snp.height)
             make.center.equalToSuperview()
         }
     }
 }
