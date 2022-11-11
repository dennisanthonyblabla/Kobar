//
//  DokumentasiView.swift
//  Macro Challenge Team2
//
//  Created by Dennis Anthony on 10/11/22.
//

import UIKit
import SwiftUI
import SnapKit
import WebKit

final class DokumentasiViewController: UIViewController {
    private lazy var closeBtn: SmallIconButtonView = {
        let btn = SmallIconButtonView(variant: .variant1, buttonImage: UIImage(systemName: "xmark"))
        btn.addAction(
            UIAction { _ in
                print("Touched Close")
            },
            for: .touchUpInside
        )
        return btn
    }()

    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundDokumentasi")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dokumentasi Gaul-Lang!"
        label.textColor = .kobarBlack
        label.font = .regular34
        return label
    }()

    private lazy var showHTML: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    private lazy var variabelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Variabel", for: .normal)
        defaultBtnConf(btn: btn)
        return btn
    }()

    private lazy var operatorBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Operator & Aritmatika", for: .normal)
        defaultBtnConf(btn: btn)
        return btn
    }()

    private lazy var ioBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Input & Ouput", for: .normal)
        defaultBtnConf(btn: btn)
        return btn
    }()

    private lazy var selectionBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Selection (if-else)", for: .normal)
        defaultBtnConf(btn: btn)
        return btn
    }()

    private lazy var loopingBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Looping", for: .normal)
        defaultBtnConf(btn: btn)
        return btn
    }()

    private lazy var arrayBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Array", for: .normal)
        defaultBtnConf(btn: btn)
        return btn
    }()

    private lazy var leftBtnSV: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                variabelBtn,
                operatorBtn,
                ioBtn,
                selectionBtn,
                loopingBtn,
                arrayBtn
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(background)
        view.addSubview(showHTML)
        view.addSubview(titleLabel)
        view.addSubview(closeBtn)
        view.addSubview(leftBtnSV)

        setupAutoLayout()
    }

    private func setupAutoLayout() {
        background.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(background.snp.width)
            make.height.equalTo(background.snp.height)
        }
        showHTML.snp.makeConstraints { make in
            make.trailing.equalTo(background).offset(-18)
            make.top.equalTo(background).offset(78)
            make.width.equalTo(background).multipliedBy(0.65)
            make.height.equalTo(background).multipliedBy(0.895)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(background).offset(20)
            make.centerX.equalTo(background)
        }
        closeBtn.snp.makeConstraints { make in
            make.trailing.equalTo(background).offset(-20)
            make.top.equalTo(background).offset(12)
        }
        leftBtnSV.snp.makeConstraints { make in
            make.leading.equalTo(background).offset(12)
            make.top.equalTo(showHTML).offset(20)
            make.width.equalTo(195)
            make.height.equalTo(370)
        }
        variabelBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        operatorBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        ioBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        selectionBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        loopingBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        arrayBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }

    @objc func isBtnSelected(_ sender: UIButton) {
        variabelBtn.isSelected = false
        operatorBtn.isSelected = false
        ioBtn.isSelected = false
        selectionBtn.isSelected = false
        loopingBtn.isSelected = false
        arrayBtn.isSelected = false
        sender.isSelected = true

        isSelectedTrue(btn: variabelBtn)
        isSelectedTrue(btn: operatorBtn)
        isSelectedTrue(btn: ioBtn)
        isSelectedTrue(btn: selectionBtn)
        isSelectedTrue(btn: loopingBtn)
        isSelectedTrue(btn: arrayBtn)

        switch sender {
        case variabelBtn:
            loadHTML(name: "Variabel")
        case operatorBtn:
            loadHTML(name: "Operator_Aritmatika")
        case ioBtn:
            loadHTML(name: "Input_Output")
        case selectionBtn:
            loadHTML(name: "SelectionIf-else")
        case loopingBtn:
            loadHTML(name: "Looping")
        case arrayBtn:
            loadHTML(name: "Array")
        default:
            break
        }
    }

    private func loadHTML(name: String) {
        let htmlPath = Bundle.main.path(forResource: name, ofType: "html")
        let url = URL(fileURLWithPath: htmlPath ?? "none")
        let request = URLRequest(url: url)
        self.showHTML.load(request)
    }

    private func isSelectedTrue(btn: UIButton) {
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            if btn.isSelected == true {
                btn.setTitleColor(.white, for: .normal)
                btn.setTitleColor(.white, for: .highlighted)
                btn.backgroundColor = .kobarBlueActive
                UIView.animate(
                    withDuration: 1.5,
                    delay: 0,
                    options: [.curveEaseInOut],
                    animations: {
                        btn.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
                        btn.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                        btn.alpha = 1
                    },
                    completion: nil
                )
            } else {
                self.defaultBtnConf(btn: btn)
            }
        }.startAnimation()
    }

    private func defaultBtnConf(btn: UIButton) {
        btn.backgroundColor = .clear
        btn.setTitleColor(.kobarBlueActive, for: .normal)
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(isBtnSelected(_: )), for: .touchUpInside)
    }
}

struct DokumentasiViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return UINavigationController(rootViewController: DokumentasiViewController())
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)")
        .previewInterfaceOrientation(.landscapeLeft)
        .ignoresSafeArea()
    }
}
