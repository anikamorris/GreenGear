//
//  ProfileViewController.swift
//  GreenGear
//
//  Created by Anika Morris on 7/3/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var branchTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var user: User?
    var hasBeenSaved: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSaveButton()
        setupTextFields()
        if let _ = UserDefaults.standard.string(forKey: "UserId") {
            hasBeenSaved = true
            self.savedState()
            usernameTextField.text = UserDefaults.standard.string(forKey: "Username")
            branchTextField.text = UserDefaults.standard.string(forKey: "Branch")
            yearsTextField.text = UserDefaults.standard.string(forKey: "Years")
        }
    }
    
    func setupTextFields() {
        usernameTextField.setPlaceholder(text: "Choose a unique username")
        yearsTextField.setPlaceholder(text: "What years were you active? (eg. 1998-2007)")
        branchTextField.setPlaceholder(text: "What's your branch?")
    }
    
    func setupSaveButton() {
        saveButton.layer.cornerRadius = 5
        saveButton.clipsToBounds = true
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if hasBeenSaved == false {
            showSpinner(onView: self.view)
            let username = usernameTextField.text!
            let years = yearsTextField.text!
            let branch = branchTextField.text!
            let user = User(username: username, branch: branch, years: years)
            self.user = user
            API().createUser(user: user) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case let .success(id):
                    let stringId = id as? String
                    if let safeId = stringId {
                        self.saveUserToUserDefaults(
                            id: safeId,
                            username: self.user!.username,
                            branch: self.user!.branch,
                            years: self.user!.years
                        )
                        self.savedState()
                        self.hasBeenSaved.toggle()
                        print("has been saved: \(self.hasBeenSaved)")
                        self.removeSpinner()
                        self.showAlert(title: "Success", message: "Profile saved!")
                    } else {
                        self.removeSpinner()
                        self.showAlert(title: "Error", message: "Unique username required.")
                    }
                case let .failure(error):
                    self.removeSpinner()
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        } else {
            editState()
            hasBeenSaved.toggle()
        }
    }
    
    func saveUserToUserDefaults(id: String, username: String, branch: String, years: String) {
        UserDefaults.standard.set(id, forKey: "UserId")
        UserDefaults.standard.set(username, forKey: "Username")
        UserDefaults.standard.set(branch, forKey: "Branch")
        UserDefaults.standard.set(years, forKey: "Years")
    }
    
    public func editState() {
        saveButton.setTitle("Save", for: .normal)
        usernameTextField.isUserInteractionEnabled = true
        yearsTextField.isUserInteractionEnabled = true
        branchTextField.isUserInteractionEnabled = true
    }
    
    public func savedState() {
        saveButton.setTitle("Edit", for: .normal)
        usernameTextField.isUserInteractionEnabled = false
        yearsTextField.isUserInteractionEnabled = false
        branchTextField.isUserInteractionEnabled = false
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


