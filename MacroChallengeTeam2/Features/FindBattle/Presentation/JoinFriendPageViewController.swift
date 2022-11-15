//
//  SiapTandingViewController.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import UIKit
import SnapKit
import RxSwift

// TODO: @salman add title view
class JoinFriendPageViewController: UIViewController {
    var onCancel: (() -> Void)?
    var onConfirm: ((String) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private var inviteCode: String = ""
    
    // TODO: @salman ini imagenya kenapa ada whitespace gitu yak??
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "alertCardBackground")
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Masukin kodenya"
        label.font = .medium22
        return label
    }()
    
    private lazy var inviteCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ketik kode"
        textField.textAlignment = .center
        textField.font = .regular24
        textField.backgroundColor = .kobarGray
        textField.layer.cornerRadius = 20
        
        textField.addAction(
            UIAction { _ in
                self.inviteCode = textField.text ?? ""
            }, for: .editingChanged)
        
        return textField
    }()

    
    // TODO: maybe add shake when code is invalid
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        
        let cancelButton = SmallButtonView(
            variant: .variant3,
            title: "Batal",
            btnType: .normal)
        
        let confirmButton = SmallButtonView(
            variant: .variant1,
            title: "Gabung",
            btnType: .normal)
        
        cancelButton.addVoidAction(onCancel, for: .touchDown)
        confirmButton.addVoidAction({
            self.onConfirm?(self.inviteCode)
        }, for: .touchDown)
        
        stack.addArrangedSubview(cancelButton)
        stack.addArrangedSubview(confirmButton)
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        view.addSubview(promptLabel)
        view.addSubview(inviteCodeTextField)
        view.addSubview(buttonsStackView)
        
        // Do any additional setup after loading the view.
        inviteCodeTextField.delegate = self
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        backgroundView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.centerY.equalToSuperview()
        }
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView).multipliedBy(0.85)
            make.width.equalTo(backgroundView).multipliedBy(0.7)
            make.centerX.equalTo(backgroundView)
        }
        inviteCodeTextField.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(buttonsStackView)
            make.bottom.equalTo(buttonsStackView.snp.top).offset(-18)
            make.centerX.equalTo(backgroundView)
        }
        promptLabel.snp.makeConstraints { make in
            make.bottom.equalTo(inviteCodeTextField.snp.top).offset(-20)
            make.centerX.equalTo(backgroundView)
        }
    }
}

extension JoinFriendPageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        inviteCode = ""
    }
}
