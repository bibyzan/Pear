//
//  ViewController.swift
//  Pear
//
//  Created by Bennett Rasmussen on 3/3/18.
//  Copyright © 2018 Moves Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ResultCell: UITableViewCell {
    init(_ string: String, icon: UIImage? = nil) {
        super.init(style: .default, reuseIdentifier: nil)
        self.textLabel?.text = string
        
        if let icon = icon {
            let imageView = UIImageView(image: icon)
            imageView.frame = CGRect(x: self.frame.width, y: 5, width: 30, height: 30)
            self.addSubview(imageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var resultCells: [ResultCell] = []
    
    @IBOutlet weak var tableChats: UITableView!
    
    var chatRefHandle: DatabaseHandle?
    
    static func loadNavFromStoryboard()->UINavigationController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listview") as! UINavigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButton = UIButton(type: .custom)
        logoutButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        logoutButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        logoutButton.addTarget(self, action: #selector(self.signOutTapped(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
        let userButton = UIButton(type: .custom)
        userButton.setTitle("you", for: .normal)
        userButton.setTitleColor(.blue, for: .normal)
        userButton.sizeToFit()
        userButton.addTarget(self, action: #selector(self.userSettingsTapped(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userButton)
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))

        searchBar.placeholder = "find your 🍐"
        searchBar.delegate = self
        self.tableChats.tableHeaderView = searchBar
    }
    
    @objc func userSettingsTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(SocialAccountsViewController.loadFromStoryboard(), animated: true)
    }
    
    @objc func signOutTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sign Out", message: "are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            try? Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            FirebaseManager.emailsRef.observeSingleEvent(of: .value) { snapshot in
                if let children = snapshot.children.allObjects as? [DataSnapshot] {
                    self.resultCells = []
                    for child in children {
                        if let data = child.value as? [String: Any],
                            let email = data[User.emailKey] as? String {
                            if email.lowercased().contains(searchText.lowercased()) {
                                self.resultCells.append(ResultCell(email))
                            }
                            if let snapchat = data[User.snapchatKey] as? String,
                                snapchat.lowercased().contains(searchText.lowercased()) {
                                self.resultCells.append(ResultCell(snapchat, icon: #imageLiteral(resourceName: "snapchat")))
                            }
                            if let instagram = data[User.instagramKey] as? String,
                                instagram.lowercased().contains(searchText.lowercased()) {
                                self.resultCells.append(ResultCell(instagram, icon: #imageLiteral(resourceName: "instagram")))
                            }
                            if let twitter = data[User.twitterKey] as? String,
                                twitter.lowercased().contains(searchText.lowercased()) {
                                self.resultCells.append(ResultCell(twitter, icon: #imageLiteral(resourceName: "twitter")))
                            }
                            if let facebook = data[User.facebookKey] as? String,
                                facebook.lowercased().contains(searchText.lowercased()) {
                                self.resultCells.append(ResultCell(facebook, icon: #imageLiteral(resourceName: "facebookicon")))
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableChats.reloadData()
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.resultCells[indexPath.row]
    }
}

