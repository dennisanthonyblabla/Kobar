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

    var role: Role = .user

    private lazy var playerName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Nama"
        label.textColor = .white
        label.font = UIFont(name: "SFProRounded-Medium", size: 22)
        return label
    }()
    private lazy var profileBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "kobarGray")
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 7
        view.layer.borderColor = UIColor(named: "kobarYellow")?.cgColor
        return view
    }()
    private lazy var profileView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 128)
        let profile = UIImage(systemName: "person.fill", withConfiguration: config)?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        imageView.image = profile
        return imageView
    }()
     private lazy var ratingHolder: UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = UIColor(named: "kobarYellow")
         view.layer.cornerRadius = 22
         view.addSubview(ratingStarView)
         view.addSubview(rating)
         return view
     }()
    private lazy var ratingStarView: UIImageView = {
        let imageView = UIImageView()
        var ratingStar = UIImage(named: "ratingStar")
        imageView.image = ratingStar
        return imageView
    }()
    private lazy var rating: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "0"
        label.textColor = .white
        label.font = UIFont(name: "SFProRounded-Bold", size: 28)
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
         ratingStarView.snp.makeConstraints { (make) in
             make.width.equalTo(26.73)
             make.height.equalTo(25.61)
             make.leading.equalTo(ratingHolder.snp.leading).inset(20)
             make.centerY.equalToSuperview()
         }
         rating.snp.makeConstraints { (make) in
             make.width.equalTo(rating.snp.width)
             make.height.equalTo(rating.snp.height)
             make.trailing.equalTo(ratingHolder.snp.trailing).inset(20)
             make.centerY.equalToSuperview()
         }
         playerName.snp.makeConstraints { (make) in
             make.width.equalTo(playerName.snp.width)
             make.height.equalTo(playerName.snp.height)
             make.bottom.equalTo(profileBG.snp.top).inset(-23)
             make.centerX.equalToSuperview()
         }
         profileView.snp.makeConstraints { (make) in
             make.width.equalTo(profileView.snp.width)
             make.height.equalTo(profileView.snp.height)
             make.center.equalToSuperview()
         }
     }
 }

