//
//  TestCaseVC.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 10/11/22.
//

import UIKit
import SwiftUI
import SnapKit

class TestCaseViewController: UIPageViewController {
    private var testCaseCount = 5
    private lazy var testCaseBtn: [TestCaseButton] = []
    private lazy var lanjutBtn = MedButtonView(variant: .variant2, title: "lanjut")

    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testCaseBG")
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Case"
        label.font = .bold34
        label.textColor = .kobarBlack
        return label
    }()

    private lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.text = "Input"
        label.font = .semi17
        label.textColor = .kobarBlack
        return label
    }()

    private lazy var outputLoLabel: UILabel = {
        let label = UILabel()
        label.text = "Output Lo"
        label.font = .semi17
        label.textColor = .kobarBlack
        return label
    }()

    private lazy var outputHarapLabel: UILabel = {
        let label = UILabel()
        label.text = "Ouptut Yang Diharapkan"
        label.font = .semi17
        label.textColor = .kobarBlack
        return label
    }()

    private lazy var inputBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarGrayContoh
        view.layer.cornerRadius = 15
        view.addSubview(textInput)
        return view
    }()

    private lazy var outputLoBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarGrayContoh
        view.layer.cornerRadius = 15
        view.addSubview(textOutputLo)
        return view
    }()

    private lazy var outputHarapBG: UIView = {
        let view = UIView()
        view.backgroundColor = .kobarGrayContoh
        view.layer.cornerRadius = 15
        view.addSubview(textOutputHarap)
        return view
    }()

    private lazy var textInput: UITextView = {
        let textView = UITextView.init()
        textView.textColor = .kobarBlack
        textView.font = UIFont.regular17
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.text = "Ini inputnya"
        return textView
    }()

    private lazy var textOutputLo: UITextView = {
        let textView = UITextView.init()
        textView.textColor = .kobarBlack
        textView.font = UIFont.regular17
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.text = "Ini Ouptut Lo"
        return textView
    }()

    private lazy var textOutputHarap: UITextView = {
        let textView = UITextView.init()
        textView.textColor = .kobarBlack
        textView.font = UIFont.regular17
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.text = "Ini output harapan"
        return textView
    }()

    private lazy var testCases: [TestCaseButton] = {
        var testCases: [TestCaseButton] = []
        for i in 1...testCaseCount {
            testCases.append(TestCaseButton(style: .fill, status: .correct, order: i))
        }
        return testCases
    }()

    private lazy var testCaseSV: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: testCases)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kobarBlueActive

        view.addSubview(background)
        view.addSubview(lanjutBtn)
        view.addSubview(titleLabel)
        view.addSubview(inputBG)
        view.addSubview(outputLoBG)
        view.addSubview(outputHarapBG)
        view.addSubview(inputLabel)
        view.addSubview(outputLoLabel)
        view.addSubview(outputHarapLabel)
        view.addSubview(testCaseSV)

        setupBackground()
        setupDisplays()
        setupComponents()
    }

    private func setupBackground() {
        background.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        inputBG.snp.makeConstraints { make in
            make.trailing.equalToSuperview().multipliedBy(0.91)
            make.width.equalTo(698)
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(200)
        }
        outputLoBG.snp.makeConstraints { make in
            make.leading.equalTo(inputBG)
            make.trailing.equalTo(inputBG.snp.centerX).offset(-10)
            make.top.equalTo(outputLoLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-165)
        }
        outputHarapBG.snp.makeConstraints { make in
            make.trailing.equalTo(inputBG)
            make.leading.equalTo(outputHarapLabel)
            make.top.equalTo(outputLoBG)
            make.bottom.equalTo(outputLoBG)
        }
    }

    private func setupDisplays() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(90)
        }
        inputLabel.snp.makeConstraints { make in
            make.bottom.equalTo(inputBG.snp.top).offset(-10)
            make.leading.equalTo(inputBG)
        }
        outputLoLabel.snp.makeConstraints { make in
            make.leading.equalTo(inputBG)
            make.top.equalTo(inputBG.snp.bottom).offset(15)
        }
        outputHarapLabel.snp.makeConstraints { make in
            make.leading.equalTo(inputBG.snp.centerX).offset(10)
            make.top.equalTo(outputLoLabel)
        }
        textInput.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-17)
            make.width.equalToSuperview().offset(-30)
            make.center.equalToSuperview()
        }
        textOutputLo.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-17)
            make.width.equalToSuperview().offset(-30)
            make.center.equalToSuperview()
        }
        textOutputHarap.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(-17)
            make.width.equalToSuperview().offset(-30)
            make.center.equalToSuperview()
        }
    }

    private func setupComponents() {
        lanjutBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.bottom.equalToSuperview().offset(-30)
        }
        testCaseSV.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(165)
            make.top.equalToSuperview().offset(180)
        }
    }
}

struct TestCaseViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: TestCaseViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
