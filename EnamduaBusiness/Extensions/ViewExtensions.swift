//
//  ViewExtensions.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 02/05/23.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async {
            [weak self] in
            guard let urlString = URL(string: url) else { return }
            if let data = try? Data(contentsOf: urlString) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


