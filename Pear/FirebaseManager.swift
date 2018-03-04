//
//  FirebaseManager.swift
//  Pear
//
//  Created by Bennett Rasmussen on 3/3/18.
//  Copyright © 2018 Moves Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

extension User {
    static let snapchatKey = "snapchat"
    static let instagramKey = "instagram"
    static let twitterKey = "twitter"
    static let facebookKey = "facebook"
    static let emailKey = "email"
    
    func getSnapchat(_ completion: @escaping (String?)->Void) {
        FirebaseManager.emailsRef.child(self.uid).observe(.value) { snapshot in
            if let userDictionary = snapshot.value as? [String : AnyObject] {
                completion(userDictionary[User.snapchatKey] as? String)
            } else {
                completion(nil)
            }
        }
    }
    
    func getTwitter(_ completion: @escaping (String?)->Void) {
        FirebaseManager.emailsRef.child(self.uid).observe(.value) { snapshot in
            if let userDictionary = snapshot.value as? [String : AnyObject] {
                completion(userDictionary[User.twitterKey] as? String)
            } else {
                completion(nil)
            }        }
    }
    
    func getInstagram(_ completion: @escaping (String?)->Void) {
        FirebaseManager.emailsRef.child(self.uid).observe(.value) { snapshot in
            if let userDictionary = snapshot.value as? [String : AnyObject] {
                completion(userDictionary[User.instagramKey] as? String)
            } else {
                completion(nil)
            }
        }
    }
    
    func getFacebook(_ completion: @escaping (String?)->Void) {
        FirebaseManager.emailsRef.child(self.uid).observe(.value) { snapshot in
            if let userDictionary = snapshot.value as? [String : AnyObject] {
                completion(userDictionary[User.facebookKey] as? String)
            } else {
                completion(nil)
            }
        }
    }
    
}

class FirebaseManager {
    static var chatRef = Database.database().reference().child("chats")
    static var emailsRef = Database.database().reference().child("emails")
    
git push -u origin master
    static func saveUserSocialAccounts(_ data: [String: Any]) {
        if let user = Auth.auth().currentUser {
            let emailRef = emailsRef.child(user.uid)
            emailRef.setValue(data)
            
        }
    }
}
