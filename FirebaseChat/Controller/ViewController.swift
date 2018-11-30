//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Bernard on 21/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

class MessageController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else {
            
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: {
                (snapshot) in
                if let dictionary = snapshot.value as? NSDictionary {
                    self.navigationItem.title = dictionary["Name"] as? String ?? ""
                }
                print(snapshot)
                
            }, withCancel: nil)
            
        }
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

