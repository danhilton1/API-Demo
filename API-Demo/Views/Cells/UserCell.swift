//
//  UserCell.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userImageView: IconImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let reuseID = "UserCell"
    var url = "https://api.adorable.io/avatars/150/.png" {  // default placeholder image
        didSet {
            userImageView.downloadImage(fromURL: url)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 18
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowRadius = 1.2
        cellView.layer.shadowOffset = .zero
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        updateViewForUserInterfaceStyle()
    }

    
    func updateViewForUserInterfaceStyle() {
        if traitCollection.userInterfaceStyle == .dark {
            cellView.backgroundColor = .systemGray6
        }
        else {
            cellView.backgroundColor = .white
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateViewForUserInterfaceStyle()
    }
    
    
}
