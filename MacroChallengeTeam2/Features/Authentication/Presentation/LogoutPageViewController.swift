//
//  LogoutPageViewController.swift
//  Kobar
//
//  Created by Dennis Anthony on 23/07/23.
//

import UIKit
import SnapKit
import SwiftUI

class LogoutPageViewController: UIViewController {
    var onCancel: (() -> Void)?
    var onLogout: (() -> Void)?
    var onDeleteAccount: (() -> Void)?

    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "notificationCard")
        view.contentMode = .scaleToFill
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Keluar Akun"
        label.font = .semi28
        label.textColor = .white
        return label
    }()

    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Lo yakin mau keluar akun?"
        label.font = .regular22
        return label
    }()
    
    private lazy var deleteAccLabel: UILabel = {
        let label = UILabel()
        label.text = "Hapus Akun"
        label.font = .regular17
        label.textColor = .kobarRed
        return label
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()

        let cancelButton = MedButtonView(
            variant: .variant1,
            title: "Batal")

        let logoutButton = MedButtonView(
            variant: .variant4,
            title: "Keluar")

        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(132)
        }

        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(132)
        }

        cancelButton.addVoidAction(onCancel, for: .touchUpInside)
    
        logoutButton.addVoidAction(onLogout, for: .touchUpInside)

        stack.addArrangedSubview(cancelButton)
        stack.addArrangedSubview(logoutButton)
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
        view.addSubview(deleteAccLabel)
        
        deleteAccLabel.isUserInteractionEnabled = true
        deleteAccLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDeleteAccountTapped)))

        // Do any additional setup after loading the view.

        setupAutoLayout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        if isBeingDismissed {
            onCancel?()
        }
        super.viewDidDisappear(animated)
    }
                                            
    @objc func onDeleteAccountTapped() {
        onDeleteAccount?()
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
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.centerX.equalTo(backgroundView)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(promptLabel.snp.bottom).inset(-50)
            make.width.equalTo(300)
            make.centerX.equalTo(backgroundView)
        }
        deleteAccLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(16)
            make.centerX.equalTo(buttonsStackView)
        }
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

struct LogoutPageViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: LogoutPageViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
