//
//  UIImageViewExtensions.swift
//  idealistaChallenge
//
//  Created by diegitsen on 16/12/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String, placeholder: UIImage? = nil) {
        self.image = placeholder
        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
