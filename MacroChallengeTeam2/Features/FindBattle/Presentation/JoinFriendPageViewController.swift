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
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "notificationCard")
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gabung Teman"
        label.font = .semi28
        label.textColor = .white
        return label
    }()
    
    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Masukin kodenya"
        label.font = .regular22
        return label
    }()
    
    private lazy var inviteCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ketik kode"
        textField.textAlignment = .center
        textField.font = .regular24
        textField.backgroundColor = .kobarGray
        textField.layer.cornerRadius = 20
        textField.autocapitalizationType = .allCharacters
        textField.autocorrectionType = .no
        
        textField.addAction(
            UIAction { _ in
                self.inviteCode = textField.text ?? ""
            }, for: .editingChanged)
        
        textField.addAction(
            UIAction { _ in
                self.inviteCode = ""
            }, for: .editingDidBegin)
        
        return textField
    }()

    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        
        let cancelButton = MedButtonView(
            variant: .variant3,
            title: "Batal")
        
        let confirmButton = MedButtonView(
            variant: .variant1,
            title: "Gabung")
        
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(132)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.width.equalTo(132)
        }
        
        cancelButton.addVoidAction(onCancel, for: .touchUpInside)
        confirmButton.addVoidAction({
            self.onConfirm?(self.inviteCode)
        }, for: .touchUpInside)
        
        stack.addArrangedSubview(cancelButton)
        stack.addArrangedSubview(confirmButton)
        stack.alignment = .center
        stack.distribution = .equalCentering
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(promptLabel)
        view.addSubview(inviteCodeTextField)
        view.addSubview(buttonsStackView)
        
        // Do any additional setup after loading the view.
        inviteCodeTextField.delegate = self
        
        setupAutoLayout()
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isBeingDismissed {
            onCancel?()
        }
        super.viewDidDisappear(animated)
    }
    
    private func setupAutoLayout() {
        backgroundView.snp.makeConstraints { make in
            make.height.equalTo(340)
            make.width.equalTo(520)
            make.centerX.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView).inset(25)
            make.centerX.equalTo(backgroundView)
        }
        promptLabel.snp.makeConstraints { make in
            make.bottom.equalTo(inviteCodeTextField.snp.top).offset(-10)
            make.centerX.equalTo(backgroundView)
        }
        inviteCodeTextField.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(buttonsStackView)
            make.bottom.equalTo(buttonsStackView.snp.top).offset(-25)
            make.centerX.equalTo(backgroundView)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView).inset(45)
            make.width.equalTo(300)
            make.centerX.equalTo(backgroundView)
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onShowKeyboard),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onHideKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func onShowKeyboard(notification: NSNotification) {
        backgroundView.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(-70)
        }
        animationLayout()
    }
    
    @objc func onHideKeyboard(notification: NSNotification) {
        backgroundView.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
        }
        animationLayout()
    }
    
    private func animationLayout() {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }
}

extension JoinFriendPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onConfirm?(textField.text ?? "")
        return true
    }
}
