//
//  SnippetKeyboardVC.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 20/11/22.
//

import UIKit
import SwiftUI

struct SnippetModel {
    let title: String
    let snippet: String
}

class SnippetKeyboardVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private lazy var snippets: [SnippetModel] = {
        var snippets: [SnippetModel] = []
        snippets.append(SnippetModel(title: "baca", snippet: "baca _"))
        snippets.append(SnippetModel(title: "ulangin", snippet: "ulangin"))
        snippets.append(SnippetModel(title: "tulis", snippet: "tulis _"))
        snippets.append(SnippetModel(title: "kalo", snippet: "kalo _"))
        snippets.append(SnippetModel(title: "kalogak", snippet: "baca _"))
        snippets.append(SnippetModel(title: "yaudah", snippet: "yaudah"))
        snippets.append(SnippetModel(title: "dan", snippet: "dan"))
        snippets.append(SnippetModel(title: "atau", snippet: "atau"))
        snippets.append(SnippetModel(title: "selama", snippet: "selama _"))
        snippets.append(SnippetModel(title: "+", snippet: "ditambah"))
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
        collectionView.backgroundColor = .kobarGray
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(keyboard)
        keyboard.dataSource = self
        keyboard.delegate = self
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        keyboard.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
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
            fatalError("aaaaaa")
        }
        
        let snippet = snippets[indexPath.row]
        cell.snippet = snippet.snippet
        cell.btnLabel = snippet.title

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
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
