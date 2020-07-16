//
//  ProfileViewController.swift
//  GreenGear
//
//  Created by Anika Morris on 7/3/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit

enum ProfileState {
    case saved
    case edit
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var branchTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var profileState: ProfileState = .edit {
        didSet {
            switch profileState {
            case .edit: editState()
            case .saved: savedState()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let username = usernameTextField.text!
        let years = yearsTextField.text!
        let branch = branchTextField.text!
        let user = User(username: username, branch: branch, years: years)
        API().createUser(user: user) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case let .success(id):
                let stringId = id as? String
                if let safeId = stringId {
                    UserDefaults.standard.set(safeId, forKey: "UserId")
                    self.profileState = .saved
                    self.showAlert(title: "Success", message: "Profile saved!")
                } else {
                    self.showAlert(title: "Error saving profile", message: "Try Again")
                }
                
            case let .failure(error):
                self.showAlert(title: "Error saving profile", message: error.localizedDescription)
            }
        }
    }
    
    func editState() {
        saveButton.titleLabel!.text = "Save"
        usernameTextField.isUserInteractionEnabled = true
        yearsTextField.isUserInteractionEnabled = true
        branchTextField.isUserInteractionEnabled = true
    }
    
    func savedState() {
        saveButton.titleLabel!.text = "Edit"
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
