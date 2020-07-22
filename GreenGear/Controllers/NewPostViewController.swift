//
//  NewPostViewController.swift
//  GreenGear
//
//  Created by Anika Morris on 7/8/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

protocol NewPostDelegate {
    func prependPost(post: Post)
}

class NewPostViewController: UIViewController {
    
    var newPostDelegate: NewPostDelegate!
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Helvetica", size: 16.0)
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        return textView
    }()
    
    let titleTextField: TextField = {
        let textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Title"
        textField.font = UIFont(name: "Helvetica", size: 18.0)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        return textField
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
        self.view.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.2196078431, blue: 0.1803921569, alpha: 1)
        setupPostLabel()
        setupTitleTextField()
        setupPostTextView()
        setupSubmitButton()
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    func setupPostLabel() {
        view.addSubview(newPostLabel)
        NSLayoutConstraint.activate([
            newPostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPostLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            newPostLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            newPostLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupTitleTextField() {
        view.addSubview(titleTextField)
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: newPostLabel.bottomAnchor, constant: 10),
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupPostTextView() {
        view.addSubview(postTextView)
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            postTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            postTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            postTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
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
        showSpinner(onView: self.view)
        let title = titleTextField.text!
        let body = postTextView.text!
        let author = UserDefaults.standard.string(forKey: "Username")
        let newPost = Post(title: title, body: body, author: author!)
        API().newPost(post: newPost) { [weak self] (result) in
            print(result)
            guard let self = self else { return }
            self.newPostDelegate.prependPost(post: newPost)
            self.removeSpinner()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
