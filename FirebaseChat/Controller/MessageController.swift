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
            self.setupNavTitle()
           
        }
    }

    func setupNavTitle() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
//                self.navigationItem.title = dictionary["Name"] as? String
            
                let user = User()
                user.name = dictionary["Name"] as? String
                user.email = dictionary["Email"] as? String
                user.profileImageUrl = dictionary["ProfileImageUrl"] as? String
                
                self.setupProfileImageWithNavTitle(user)
            }
        }, withCancel: nil)
    }
    
    func setupProfileImageWithNavTitle(_ user: User) {
        
        let titleView = UIView()
        
        let nameLabel = UILabel()
        titleView.addSubview(nameLabel)
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let profileImageView = UIImageView()
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageCache(urlString: profileImageUrl)
        }
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true

        titleView.addSubview(profileImageView)

        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
        
        profileImageView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //** IMPORTANT TO SET titleView with width/height in order to tap
        titleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        //** IMPORTANT TO SET titleView with width/height in order to tap
        
        self.navigationItem.titleView = titleView

        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatLog)))
        
    }
    
    @objc func showChatLog() {
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(chatLogController, animated: true)
        
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

