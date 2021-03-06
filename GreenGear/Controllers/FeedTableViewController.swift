//
//  FeedTableViewController.swift
//  GreenGear
//
//  Created by Anika Morris on 6/26/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewController: UITableViewController {
    
    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.2352941176, blue: 0.1333333333, alpha: 1)
        self.tableView.separatorColor = .darkText
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let user = User(username: "bob", branch: "army", years: "2003-2007")
//        let comment1 = Comment(content: "I hella feel you bro", user: user)
//        let comment2 = Comment(content: "I hella feel you too bro", user: user)
//        let post = Post(content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", user: user, comments: [])
        let post = Post(title: "First Post", body: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", author: user.username)
        posts.append(post)
        API().getAllPosts { result in
            print(result)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.postTextView.text = post.body
        cell.postTextView.layer.cornerRadius = 5
        cell.postTextView.clipsToBounds = true
        cell.titleLabel.text = post.title
        if indexPath.row == 0 && post.title != "First Post" {
            cell.branchLabel.text = UserDefaults.standard.string(forKey: "Branch")
            cell.yearsActiveLabel.text = UserDefaults.standard.string(forKey: "Years")
        } else {
            cell.branchLabel.text = "Air Force"
            cell.yearsActiveLabel.text = "2003-2011"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailVC = PostDetailViewController()
        postDetailVC.post = posts[indexPath.row]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let newPostVC = NewPostViewController()
        newPostVC.newPostDelegate = self
        self.navigationController?.present(newPostVC, animated: true, completion: nil)
    }
}

extension FeedTableViewController: NewPostDelegate {
    func prependPost(post: Post) {
        self.posts.insert(post, at: 0)
    }
}
