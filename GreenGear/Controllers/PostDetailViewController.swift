//
//  PostDetailViewController.swift
//  GreenGear
//
//  Created by Anika Morris on 6/26/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var post: Post? = nil
    var comments: [Comment]? = nil
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 22.0)
        label.textAlignment = .center
        return label
    }()
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont(name: "Helvetica", size: 18.0)
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true
        return textView
    }()
    
    let commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentCell.self, forCellReuseIdentifier: "commentCell")
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if let post = self.post {
            self.title = post.title
        }
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        setupPostTextView()
        setupTitleLabel()
        
        guard let post = post else { return }
        self.post = post
//        guard let comments = post.comments else { return }
//        self.comments = comments
        if let _ = self.comments {
            setupCommentTableView()
            titleLabel.text = "Responses"
        } else {
            titleLabel.text = "No Responses Yet"
        }
        postTextView.text = post.body
    }
    
    func setupPostTextView() {
        view.addSubview(postTextView)
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            postTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            postTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func setupCommentTableView() {
        view.addSubview(commentsTableView)
        NSLayoutConstraint.activate([
            commentsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            commentsTableView.leadingAnchor.constraint(equalTo: postTextView.leadingAnchor),
            commentsTableView.trailingAnchor.constraint(equalTo: postTextView.trailingAnchor),
            commentsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 35)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let post = post, let comments = post.comments else { return 0 }
        guard let comments = self.comments else {
            return 0
        }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let comments = self.comments {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
            cell.commentLabel.text = comments[indexPath.row].content
            return cell
        } else {
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

