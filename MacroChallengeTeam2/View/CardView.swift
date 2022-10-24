//
//  CardView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 20/10/22.
//

import Foundation
import UIKit
import SnapKit

final class CardView: UIView {

    enum CardType {
        case codingCard
        case inputCard
        case outputCard
    }

    var cardType: CardType = .inputCard {
        didSet {
            switch cardType {
            case .codingCard:
                
            case .inputCard:
            case .outputCard:
            }
        }
    }

    private lazy var textInput: UITextView = {
        let textView = UITextView()
        let add = "Placeholder"
        let attributeText = NSMutableAttributedString(string: add, attributes: [NSAttributedString.Key.font: UIFont.regular17, NSAttributedString.Key.foregroundColor: UIColor.kobarDarkGray])
        textView.attributedText = attributeText
        textView.textAlignment = .left
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    private lazy var titleBanner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.kobarLightGray
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.kobarBorderGray.cgColor
        view.layer.borderWidth = 1.5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.10
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 11
        view.addSubview(titleLabel)
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .kobarBlack
        label.font = .bold17
        label.text = "Title"
        return label
    }()
    private lazy var textViewBG: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 7, height: 7)
        view.layer.shadowOpacity = 0.1
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textViewBG)
        addSubview(titleBanner)
        addSubview(textInput)
        setupAutoLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupAutoLayout() {
        titleBanner.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalToSuperview()
            make.top.equalTo(textViewBG.snp.top)
        }
        textInput.snp.makeConstraints { (make) in
//            make.width.equalToSuperview().offset(-16)
            make.trailing.equalTo(textViewBG).offset(-16)
            make.leading.equalTo(textViewBG).offset(16)
            make.top.equalTo(textViewBG).offset(62)
            make.bottom.equalTo(textViewBG).offset(-16)
        }
        textViewBG.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(titleLabel.snp.width)
            make.height.equalTo(titleLabel.snp.height)
        }
    }
}
