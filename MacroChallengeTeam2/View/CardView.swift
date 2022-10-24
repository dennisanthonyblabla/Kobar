//
//  CardView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 20/10/22.
//

import Foundation
import UIKit
import SnapKit

final class CardView: UIView, UITextViewDelegate {

    enum CardType {
        case codingCard
        case inputCard
        case outputCard
    }

    var cardType: CardType?
    var placeholderText: String?

    private lazy var textInput: UITextView = {
        let textView = UITextView.init()
        textView.delegate = self
        textView.textColor = .lightGray
        textView.font = UIFont.regular17
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
        view.backgroundColor = .kobarLightGray
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
        label.font = .bold17
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
    }

    init(type: CardType) {
        super.init(frame: .zero)
        self.cardType = type
        addSubview(textViewBG)
        addSubview(titleBanner)
        addSubview(textInput)
        self.cardStyle()
        setupAutoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func cardStyle() {
        switch cardType {
        case .codingCard:
            self.titleLabel.textColor = .kobarBlueActive
            self.titleLabel.text = "Ngoding yuk!"
            self.textInput.font = .code17
            self.textInput.text = "Ketik kodingannya di sini"
            self.placeholderText = "Ketik kodingannya di sini"
        case .inputCard:
            self.titleLabel.textColor = .kobarBlueActive
            self.titleLabel.text = "Input lo"
            self.textInput.font = .regular17
            self.textInput.text = "Ketik input lo untuk diuji"
            self.placeholderText = "Ketik input lo untuk diuji"
        case .outputCard:
            self.titleLabel.textColor = .kobarBlack
            self.titleLabel.text = "Output"
            self.textInput.font = .regular17
            self.textInput.text = "Nanti hasil dari input lo akan muncul"
            self.placeholderText = "Nanti hasil dari input lo akan muncul"
        case .none:
            self.titleLabel.textColor = .kobarBlueActive
            self.titleLabel.text = "Input lo"
            self.textInput.font = .regular17
            self.textInput.text = "Ketik input lo untuk diuji"
            self.placeholderText = "Ketik input lo untuk diuji"
        }
    }
    func setupAutoLayout() {
        titleBanner.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalToSuperview()
            make.top.equalTo(textViewBG.snp.top)
        }

        textInput.snp.makeConstraints { (make) in
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

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textInput.text == placeholderText && textInput.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() // Optional
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textInput.text == "" {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
