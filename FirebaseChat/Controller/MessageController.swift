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
//        self.navigationItem.title = user.name
        
        let title = UIView()
//        title.backgroundColor = UIColor.red

        let containerView = UIView()
        containerView.backgroundColor = UIColor.blue
        containerView.translatesAutoresizingMaskIntoConstraints = false
        title.addSubview(containerView)

        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageCache(urlString: profileImageUrl)
        }

        title.addSubview(profileImageView)

        //x, y, width, height
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
//        profileImageView.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let nameLabel = UILabel()
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        title.addSubview(nameLabel)

        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 165).isActive = true

//        containerView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
//        containerView.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        self.navigationItem.titleView = title
        
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

