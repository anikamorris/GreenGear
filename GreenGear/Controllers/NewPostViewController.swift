//
//  NewPostViewController.swift
//  GreenGear
//
//  Created by Anika Morris on 7/8/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class NewPostViewController: UIViewController {
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        return textView
    }()
    
    let newPostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "New Post"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        setupPostTextView()
        setupPostLabel()
        setupSubmitButton()
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    func setupPostTextView() {
        view.addSubview(postTextView)
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            postTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            postTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            postTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
    func setupPostLabel() {
        view.addSubview(newPostLabel)
        NSLayoutConstraint.activate([
            newPostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPostLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            newPostLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            newPostLabel.bottomAnchor.constraint(equalTo: postTextView.topAnchor, constant: -8)
        ])
    }
    
    func setupSubmitButton() {
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 5),
            submitButton.leadingAnchor.constraint(equalTo: newPostLabel.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: newPostLabel.trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func submitButtonTapped() {
//        API().newPost()
        self.dismiss(animated: true, completion: nil)
    }
}

