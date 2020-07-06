//
//  IconImageView.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class IconImageView: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
    
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(fromURL: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
