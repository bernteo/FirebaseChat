//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Bernard on 21/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

