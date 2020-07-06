//
//  PostCell.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var postTitleLabel: HeadingLabel!
    @IBOutlet weak var bodyLabel: PostBodyLabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    
    static let reuseID = "PostCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 16
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowRadius = 1.5
        cellView.layer.shadowOffset = .zero
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
