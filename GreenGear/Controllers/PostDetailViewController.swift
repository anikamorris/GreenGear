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
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont(name: "Helvetica", size: 18.0)
        return textView
    }()
    
    let commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: "CommentCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "commentCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        setupPostTextView()
        setupCommentTableView()
        guard let post = post else { return }
        self.post = post
        guard let comments = post.comments else { return }
        self.comments = comments
        postTextView.text = post.content
    }
    
    func setupPostTextView() {
        view.addSubview(postTextView)
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            postTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            postTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33)
        ])
    }
    
    func setupCommentTableView() {
        view.addSubview(commentsTableView)
        NSLayoutConstraint.activate([
            commentsTableView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 12.0),
            commentsTableView.leadingAnchor.constraint(equalTo: postTextView.leadingAnchor),
            commentsTableView.trailingAnchor.constraint(equalTo: postTextView.trailingAnchor),
            commentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15.0)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let post = post, let comments = post.comments else { return 0 }
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        guard let comments = self.comments else { return cell }
        cell.commentLabel.text = comments[indexPath.row].content
        return cell
    }
}

