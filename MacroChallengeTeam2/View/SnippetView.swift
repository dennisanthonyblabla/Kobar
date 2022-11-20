//
//  SnippetButtonView.swift
//  Macro Challenge Team2
//
//  Created by Atyanta Awesa Pambharu on 10/11/22.
//

import UIKit
import SnapKit

class SnippetView: UIView {
    var snippet: String?

    private lazy var backBG: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        view.addSubview(label)
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .kobarBlack
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBG)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSnippet(title: String, snippet: String) {
        self.label.text = title
        self.snippet = snippet
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        backBG.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(label).offset(20)
            make.center.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.height.equalTo(label.snp.height)
            make.width.equalTo(label.snp.width)
            make.center.equalToSuperview()
        }
    }
}
