//
//  CommentsViewController.swift
//  API-Demo
//
//  Created by Daniel Hilton on 06/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    
    //MARK:- Properties
    
    var post: Post!
    var comments: [Comment]?
    
    //MARK:- View Lifecycle/Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView()
    }
    
    
    private func configureViewController() {
        updateViewForUserInterfaceStyle()
        tableView.layer.cornerRadius = 18
        tableView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: PostCell.reuseID)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    //MARK:- UI/Animation
    
    private func animateTableView() {
        UIView.animate(withDuration: 0.7, delay: 0.1, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: [], animations: {
            self.tableView.transform = CGAffineTransform.identity
        })
    }
    
    
    private func dismissView() {
        UIView.animate(withDuration: 0.7, delay: 0.1, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: [], animations: {
            self.tableView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.view.alpha = 0
        }) { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    func updateViewForUserInterfaceStyle() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .light ? UIColor.black.withAlphaComponent(0.6) : UIColor.white.withAlphaComponent(0.15)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateViewForUserInterfaceStyle()
    }
    
    //MARK:- Actions
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismissView()
    }
    
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        let point = sender.location(in: view)
        if !self.tableView.frame.contains(point) {
            dismissView()
        }
    }
    
}

//MARK:- TableView Delegate & DataSource

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (comments?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as! PostCell
        
        switch indexPath.section {
        case 0:
            cell.postTitleLabel.text = post.title
            cell.bodyLabel.text = post.body
            cell.postTitleLabel.font = cell.postTitleLabel.font.withSize(22)
            cell.bodyLabel.font = cell.bodyLabel.font.withSize(20)
            cell.postTitleLabel.numberOfLines = 5
        default:
            cell.postTitleLabel.text = comments?[indexPath.row].email
            cell.bodyLabel.text = comments?[indexPath.row].body
            cell.postTitleLabel.font = cell.postTitleLabel.font.withSize(16)
            cell.bodyLabel.font = cell.bodyLabel.font.withSize(16)
        }
        
        cell.commentImageView.isHidden = true
        cell.commentCountLabel.isHidden = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView()
            headerView.backgroundColor = .systemGroupedBackground
            return headerView
        }
        else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
            let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
            headerView.addSubview(headerLabel)
            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
                headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -2)
            ])
            headerLabel.backgroundColor = .systemGroupedBackground
            headerView.backgroundColor = .systemGroupedBackground
            headerLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
            headerLabel.textColor = .systemBlue
            headerLabel.text = "Comments"
            
            return headerView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 40
    }
    
}
