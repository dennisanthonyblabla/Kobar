//
//  KeyboardCollectionViewCell.swift
//  Kobar
//
//  Created by Atyanta Awesa Pambharu on 20/11/22.
//

import UIKit

class KeyboardCollectionViewCell: UICollectionViewCell {
    static let identifier = "KeyboardCollectionViewCell"
    
    private lazy var snippetView = SnippetView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(snippetView)
    }
    
    private func setupAutoLayout() {
        snippetView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    func setSnippetView(title: String, snippet: String) {
        snippetView.setSnippet(title: title, snippet: snippet)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error cok")
    }
}
