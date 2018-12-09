//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Bernard on 23/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

class MessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(handleNewMessage))
    
        checkIfUserIsLoggedIn()
    
    }
    
    @objc func handleNewMessage() {
        let newMessage = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessage)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
            
        else {
            setupNavTitle()
           
        }
    }

    func setupNavTitle() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                
                self.navigationItem.title = dictionary["Name"] as? String
            }
        }, withCancel: nil)
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        }
        catch let userLogoutErr {
            print(userLogoutErr)
        }
        
        let loginController = LoginController()
        loginController.messageController = self
        present(loginController, animated: true, completion: nil)
    }

}

