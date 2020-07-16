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
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.isEditable = false
        textView.font = UIFont(name: "Helvetica", size: 18.0)
        textView.textColor = .white
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true
        
        textView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.2352941176, blue: 0.1333333333, alpha: 1)
        return textView
    }()
    
    let postBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CommentCell.self, forCellReuseIdentifier: "commentCell")
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        tableView.backgroundColor = .white
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
        
        setupPostBackgroundView()
        setupPostTextView()
        setupTitleLabel()
        
        self.comments = [
            Comment(content: "Yay first comment", user: "Ned"),
            Comment(content: "Wow second comment", user: "Andy"),
            Comment(content: "Cool third comment", user: "Lindsay")
        ]
        
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
    
    func setupPostBackgroundView() {
        view.addSubview(postBackgroundView)
        NSLayoutConstraint.activate([
            postBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            postBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func setupPostTextView() {
        postBackgroundView.addSubview(postTextView)
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: postBackgroundView.safeAreaLayoutGuide.topAnchor, constant: 18),
            postTextView.centerXAnchor.constraint(equalTo: postBackgroundView.centerXAnchor),
            postTextView.widthAnchor.constraint(equalTo: postBackgroundView.widthAnchor, multiplier: 0.93),
            postTextView.heightAnchor.constraint(equalTo: postBackgroundView.heightAnchor, multiplier: 0.9)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: postBackgroundView.bottomAnchor, constant: 20),
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

