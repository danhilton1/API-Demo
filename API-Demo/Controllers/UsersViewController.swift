//
//  UsersViewController.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

enum APIUrl {  // enum to hold the url strings for API calls
    static let users = "https://jsonplaceholder.typicode.com/users"
    static let posts = "https://jsonplaceholder.typicode.com/posts"
    static let comments = "https://jsonplaceholder.typicode.com/comments"
}

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    
    var users: [User] = []
    var posts: [Post] = []
    var comments: [Comment] = []
    var selectedUser: User?
    var selectedIcon: UIImage?
    
    //MARK:- View Lifecycle and Configuation
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveUsers()
        retrievePosts()
        retrieveComments()
        configureTableView()
        
    }
    
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserCell.reuseID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    //MARK:- Retrieve Data
    
    private func retrieveUsers() {
        let url = APIUrl.users
        NetworkManager.shared.downloadData(url: url) { [weak self] (result: Result<[User],CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadedUsers):
                self.users = downloadedUsers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.displayAlertOnMainThread(title: "Error", message: error.rawValue)
            }
        }
    }
    
    
    private func retrievePosts() {
        let url = APIUrl.posts
        NetworkManager.shared.downloadData(url: url) { [weak self] (result: Result<[Post],CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadedPosts):
                self.posts = downloadedPosts
            case .failure(let error):
                self.displayAlertOnMainThread(title: "Error", message: error.rawValue)
            }
        }
    }
    
    
    private func retrieveComments() {
        let url = APIUrl.comments
        NetworkManager.shared.downloadData(url: url) { [weak self] (result: Result<[Comment],CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadedComments):
                self.comments = downloadedComments
            case .failure(let error):
                self.displayAlertOnMainThread(title: "Error", message: error.rawValue)
            }
        }
    }

    //MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToUserDetail" {
            let destVC = segue.destination as! UserDetailVC
            let filteredPosts = posts.filter { $0.userId == selectedUser?.id }
            var postIDs: [Int] = []
            for post in filteredPosts {
                postIDs.append(post.id)
            }
            let filteredComments = comments.filter { postIDs.contains($0.postId) }
            destVC.posts = filteredPosts
            destVC.comments = filteredComments
            destVC.user = selectedUser
            destVC.iconImage = selectedIcon
        }
    }
    

}

//MARK:- TableView Delegate & DataSource

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as! UserCell
        
        cell.url = "https://api.adorable.io/avatars/150/\(users[indexPath.row].id).png"
        cell.usernameLabel.text = users[indexPath.row].username
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        selectedUser = users[indexPath.row]
        selectedIcon = cell.userImageView.image
        performSegue(withIdentifier: "GoToUserDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
