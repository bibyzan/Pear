//
//  PearViewController.swift
//  Pear
//
//  Created by Bennett Rasmussen on 3/4/18.
//  Copyright © 2018 Moves Inc. All rights reserved.
//

import UIKit

class PearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
