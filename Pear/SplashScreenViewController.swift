//
//  SplashScreenViewController.swift
//  Pear
//
//  Created by Bennett Rasmussen on 3/4/18.
//  Copyright © 2018 Moves Inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashScreenViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            self.present(ChatListViewController.loadNavFromStoryboard(), animated: true, completion: nil)
        } else {
            self.present(LoginViewController.loadNavFromStoryboard(), animated: true, completion: nil)
        }
    }
}
