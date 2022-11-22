//
//  UjiKodinganView.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit
import SnapKit

final class UjiKodinganView: UIView {
    var onRunCode: ((String) -> Void)?
    var onSubmitCode: ((String) -> Void)?
    
    var input = ""
    
    lazy var backBtn = SmallIconButtonView(variant: .variant2)
    
    private lazy var inputCard: CardView = {
        let card = CardView(type: .inputCard)
        
        card.onTextChanged = { text in
            self.input = text
        }
        
        return card
    }()
    
    private lazy var outputCard: CardView = {
        let card = CardView(type: .outputCard)
        
        card.layer.cornerRadius = 15
        
        return card
    }()
    
    lazy var playBtn: SmallIconButtonView = {
        let button = SmallIconButtonView(
            variant: .variant2,
            buttonImage: UIImage(systemName: "play.fill"))
        
        button.addVoidAction({
            self.onRunCode?(self.input)
        }, for: .touchUpInside)
        
        return button
    }()

    lazy var submitBtn: SmallButtonView = {
        let button = SmallButtonView(variant: .variant2, title: "Submit")
        
        button.addVoidAction({
            self.onSubmitCode?(self.input)
        }, for: .touchUpInside)
        
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Uji Kodingan"
        label.font = .bold17
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .kobarBlueUjiKodingan
        addSubview(backBtn)
        addSubview(titleLabel)
        addSubview(inputCard)
        addSubview(outputCard)
        addSubview(playBtn)
        addSubview(submitBtn)

        setupAutoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAutoLayout() {
        backBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.equalToSuperview().offset(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(85)
        }
        inputCard.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.width.greaterThanOrEqualTo(self.snp.width).multipliedBy(0.9).priority(1000)
            make.bottom.equalTo(outputCard.snp.top).offset(-15)
        }
        outputCard.snp.makeConstraints { make in
            make.leading.trailing.equalTo(inputCard)
            make.bottom.equalTo(playBtn.snp.top).offset(-30)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        playBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-75)
        }
        submitBtn.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.centerY.equalTo(playBtn)
            make.leading.equalTo(playBtn.snp.trailing).offset(30)
        }
    }
    
    func updateCodeOutput(result: RunCodeResult) {
        outputCard.text = result.output
        
        switch result.type {
        case .correct:
            outputCard.textColor = .kobarGreen
            outputCard.layer.borderWidth = 2
            outputCard.layer.borderColor = UIColor.kobarGreen.cgColor
        case .incorrect:
            outputCard.textColor = .kobarBlack
            outputCard.layer.borderWidth = 0
            outputCard.layer.borderColor = nil
        case .error:
            outputCard.textColor = .kobarRed
            outputCard.layer.borderWidth = 2
            outputCard.layer.borderColor = UIColor.kobarRed.cgColor
        }
    }
}
