//
//  KeyboardCollectionViewCell.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 20/11/22.
//

import UIKit

class KeyboardCollectionViewCell: UICollectionViewCell {
    static let identifier = "KeyboardCollectionViewCell"
    var snippet: String?
    var btnLabel: String? {
        didSet {
            label.text = btnLabel
        }
    }

    private lazy var backBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .kobarBlack
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(backBG)
        backBG.addSubview(label)
        self.clipsToBounds = true
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        backBG.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(label.snp.width).offset(22)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(label.snp.height)
            make.width.equalTo(label.snp.width)
            make.center.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(backBG.snp.width)
            make.height.equalTo(backBG.snp.height).offset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
