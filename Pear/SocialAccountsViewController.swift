//
//  SocialAccountsViewController.swift
//  Pear
//
//  Created by Bennett Rasmussen on 3/4/18.
//  Copyright © 2018 Moves Inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class SocialAccountsViewController: UIViewController {
    @IBOutlet weak var textSnapchat: UITextField!
    @IBOutlet weak var textInstagram: UITextField!
    @IBOutlet weak var textTwitter: UITextField!
    @IBOutlet weak var textFacebook: UITextField!
    
    static func loadFromStoryboard()->SocialAccountsViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "socialview") as! SocialAccountsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            user.getSnapchat() { snapchat in
                DispatchQueue.main.async {
                    self.textSnapchat.text = snapchat
                }
            }
            user.getInstagram() { instagram in
                DispatchQueue.main.async {
                    self.textInstagram.text = instagram
                }
            }
            
            user.getTwitter() { twitter in
                DispatchQueue.main.async {
                    self.textTwitter.text = twitter
                }
            }
            
            user.getFacebook() { facebook in
                DispatchQueue.main.async {
                    self.textFacebook.text = facebook
                }
            }
        }
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        var valuesToSave: [String: Any] = [:]
        
        if let snapchat = self.textSnapchat.text,
            snapchat != "" {
            valuesToSave[User.snapchatKey] = snapchat
        }
        
        if let instagram = self.textInstagram.text,
            instagram != "" {
            valuesToSave[User.instagramKey] = instagram
        }
        
        if let twitter = self.textTwitter.text,
            twitter != "" {
            valuesToSave[User.twitterKey] = twitter
        }
        
        if let facebook = self.textFacebook.text,
            facebook != "" {
            valuesToSave[User.facebookKey] = facebook
        }
        
        if let user = Auth.auth().currentUser,
            let email = user.email {
            valuesToSave[User.emailKey] = email
        }
        
        FirebaseManager.saveUserSocialAccounts(valuesToSave)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
