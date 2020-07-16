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
        // Do any additional setup after loading the view.
        let user = User(username: "bob", branch: "army", years: "2003-2007")
//        let comment1 = Comment(content: "I hella feel you bro", user: user)
//        let comment2 = Comment(content: "I hella feel you too bro", user: user)
        let post = Post(content: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", user: user, comments: [])
        
        posts.append(post)
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
        let user = post.user
        cell.postTextView.text = post.content
        cell.yearsActiveLabel.text = user.years
        cell.positionLabel.text = user.branch
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetailVC = PostDetailViewController()
        postDetailVC.post = posts[indexPath.row]
        navigationController?.pushViewController(postDetailVC, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let newPostVC = NewPostViewController()
        self.navigationController?.present(newPostVC, animated: true, completion: nil)
    }
}
