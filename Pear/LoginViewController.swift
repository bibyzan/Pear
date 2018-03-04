//
//  LoginViewController.swift
//  Pear
//
//  Created by Bennett Rasmussen on 3/3/18.
//  Copyright © 2018 Moves Inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textConfirmPassword: UITextField!
    
    static func loadNavFromStoryboard()->UINavigationController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinview") as! UINavigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textPassword.isSecureTextEntry = true
        self.textConfirmPassword.isSecureTextEntry = true
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        if let email = textEmail.text,
            let password = textPassword.text {
            
            sender.isEnabled = false
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                sender.isEnabled = true
                if let error = error {
                    let alert = UIAlertController(title: "Error signing up", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        if let email = textEmail.text,
            let password = textPassword.text,
            let confirmPassword = textConfirmPassword.text,
            email != "" && password.count > 5,
            confirmPassword == password {
            
            sender.isEnabled = false
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                sender.isEnabled = true
                if let error = error {
                    let alert = UIAlertController(title: "Error signing up", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else if let user = user {
                    let newEmailRef = FirebaseManager.emailsRef.child(user.uid)
                    
                    let emailItem = [
                        "email": email
                    ]
                    newEmailRef.setValue(emailItem)
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(SocialAccountsViewController.loadFromStoryboard(), animated: true)
                    }
                }
            }
        }
    }
}
