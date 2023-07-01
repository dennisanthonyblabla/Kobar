//
//  JoinRandomViewController.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 28/06/23.
//

import UIKit
import SnapKit
import RxSwift

class JoinRandomPageViewController: UIViewController {
    var onCancel: (() -> Void)?
    var onConfirm: ((String) -> Void)?
    
    private let disposeBag = DisposeBag()
        
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "notificationCard")
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tunggu Ya~"
        label.font = .semi28
        label.textColor = .white
        return label
    }()
    
        private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Fitur ini bakal segera hadir. Ditunggu ya!"
        label.font = .regular22
        return label
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        
        let cancelButton = MedButtonView(
            variant: .variant1,
            title: "Oke")
                
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(132)
        }
                
        cancelButton.addVoidAction(onCancel, for: .touchUpInside)
        
        stack.addArrangedSubview(cancelButton)
        stack.alignment = .center
        stack.distribution = .equalCentering
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(promptLabel)
        view.addSubview(buttonsStackView)
        
        // Do any additional setup after loading the view.
        
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
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView).inset(45)
            make.width.equalTo(300)
            make.centerX.equalTo(backgroundView)
        }
        promptLabel.snp.makeConstraints { make in            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView).offset(-15)
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
