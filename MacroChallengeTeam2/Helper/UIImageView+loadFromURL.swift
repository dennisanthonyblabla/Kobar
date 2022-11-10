//
//  UIImageView+LoadImageFromNetwork.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 09/11/22.
//

import UIKit

extension UIImageView {
    func load(from url: URL?, fallback: UIImage? = nil) {
        self.image = fallback
        
        guard let validURL = url else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: validURL) {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
