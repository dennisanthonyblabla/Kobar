//
//  SnippetKeyboardVC.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 20/11/22.
//

import UIKit
import SwiftUI

class SnippetKeyboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private lazy var snippets: [SnippetModel] = {
        var snippets: [SnippetModel] = []
        snippets.append(SnippetModel(title: "baca", snippet: "baca _"))
        snippets.append(SnippetModel(title: "tulis", snippet: "tulis _"))
        snippets.append(SnippetModel(title: "ulangin", snippet: "ulangin _ dari _ sampe _\n\t_\nyaudah"))
        snippets.append(
            SnippetModel(
                title: "ulangin longkap",
                snippet: "ulangin _ dari _ sampe _ longkap _\n\t_\nyaudah"
            )
        )
        snippets.append(SnippetModel(title: "selama", snippet: "selama _\n\t_\nyaudah"))
        snippets.append(SnippetModel(title: "kalo", snippet: "kalo _\n\t_\nyaudah"))
        snippets.append(SnippetModel(title: "kalogak", snippet: "kalogak _ \n\t_\n"))
        snippets.append(SnippetModel(title: "lainnya", snippet: "lainnya\n\t_"))
        snippets.append(SnippetModel(title: "yaudah", snippet: "yaudah"))
        snippets.append(SnippetModel(title: "dan", snippet: "dan"))
        snippets.append(SnippetModel(title: "atau", snippet: "atau"))
        snippets.append(SnippetModel(title: "bukan", snippet: "bukan"))
        snippets.append(SnippetModel(title: "itu", snippet: "itu"))
        snippets.append(SnippetModel(title: "benar", snippet: "benar"))
        snippets.append(SnippetModel(title: "salah", snippet: "salah"))
        snippets.append(SnippetModel(title: "+", snippet: "+"))
        snippets.append(SnippetModel(title: "-", snippet: "-"))
        snippets.append(SnippetModel(title: "*", snippet: "*"))
        snippets.append(SnippetModel(title: "/", snippet: "/"))
        snippets.append(SnippetModel(title: "%", snippet: "%"))
        snippets.append(SnippetModel(title: "==", snippet: "=="))
        snippets.append(SnippetModel(title: "!=", snippet: "!="))
        return snippets
    }()
    
    private let keyboard: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            KeyboardCollectionViewCell.self,
            forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .kobarGrayKeyboard
        
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        
        textView.layer.cornerRadius = 20
        textView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kobarBlueBG
        
        view.addSubview(textView)
        view.addSubview(keyboard)
        
        keyboard.dataSource = self
        keyboard.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        setupAutoLayout()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            keyboard.snp.remakeConstraints { make in
                make.height.equalTo(50)
                make.width.equalToSuperview()
                make.bottom.equalToSuperview().offset(-keyboardSize.height)
            }
            
            textView.snp.remakeConstraints { make in
                make.height.equalTo(600 - (keyboardSize.height - 67)) // ini itungannya dikira2, belom kepikiran gimana cara biar bisa rely sama value yg diketahui
                make.width.equalTo(1000)
                make.bottom.equalTo(keyboard.snp.top).offset(-5)
                make.centerX.equalToSuperview()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyboard.snp.remakeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
        }
        
        textView.snp.remakeConstraints { make in
            make.height.equalTo(600)
            make.width.equalTo(1000)
            make.center.equalToSuperview()
        }
    }
    
    private func setupAutoLayout() {
        keyboard.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
        }
        
        textView.snp.makeConstraints { make in
            make.height.equalTo(600)
            make.width.equalTo(1000)
            make.center.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snippets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = keyboard.dequeueReusableCell(
            withReuseIdentifier: KeyboardCollectionViewCell.identifier,
            for: indexPath
        ) as? KeyboardCollectionViewCell else {
            fatalError("error")
        }
        
        let snippet = snippets[indexPath.row]
        cell.snippet = snippet.snippet
        cell.btnLabel = snippet.title

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snippet = snippets[indexPath.row]
        if let textRange = textView.selectedTextRange {
            textView.replace(textRange, withText: snippet.snippet)
        }
    }
}

struct SnippetKeyboardPreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            return SnippetKeyboardVC()
        }
        .previewDevice("iPad Pro (11-inch) (3rd generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
