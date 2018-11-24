//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Bernard on 21/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogout))
        
        if Auth.auth().currentUser?.uid != nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    @objc func handleLogout() {
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

