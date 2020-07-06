//
//  UserDetailVC.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var iconImageView: IconImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    
    var user: User!
    var iconImage: UIImage!
    var posts: [Post] = []
    var comments: [Comment] = []
    var selectedPost: Post?

    //MARK:- View Lifecycle and Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureTableView()
        
    }
    

    private func configureViews() {
        navigationItem.title = user.username
        userInfoView.layer.cornerRadius = 18
        userInfoView.layer.shadowColor = UIColor.lightGray.cgColor
        userInfoView.layer.shadowOpacity = 0.3
        userInfoView.layer.shadowRadius = 1.5
        userInfoView.layer.shadowOffset = .zero
        updateViewForUserInterfaceStyle()
        iconImageView.image = iconImage
        nameLabel.text = user.name
        emailLabel.text = user.email
        addressLabel.text = "\(user.address.suite)\n\(user.address.street)\n\(user.address.city)\n\(user.address.zipcode)"
    }
    
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: PostCell.reuseID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    //MARK:- UI
    
    func updateViewForUserInterfaceStyle() {
        userInfoView.backgroundColor = traitCollection.userInterfaceStyle == .light ? .white : .systemGray6
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateViewForUserInterfaceStyle()
    }
    
    //MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToComments" {
            let destVC = segue.destination as! CommentsViewController
            destVC.post = selectedPost
            destVC.comments = comments.filter { $0.postId == selectedPost?.id }
        }
    }

}


//MARK:- TableView Delegate & DataSource

extension UserDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as! PostCell
        
        cell.postTitleLabel.text = posts[indexPath.row].title
        var commentCount = 0
        for comment in comments {
            if comment.postId == posts[indexPath.row].id {
                commentCount += 1
            }
        }
        cell.commentCountLabel.text = "\(commentCount)"
        cell.bodyLabel.text = posts[indexPath.row].body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = posts[indexPath.row]
        performSegue(withIdentifier: "GoToComments", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
