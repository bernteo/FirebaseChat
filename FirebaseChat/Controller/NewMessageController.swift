//
//  NewMessageController.swift
//  FirebaseChat
//
//  Created by Bernard on 9/12/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    
    var userArray = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    func fetchUser() {
        //DOWNLOAD
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
        
                let user = User()
                user.name = dictionary["Name"] as? String
                user.email = dictionary["Email"] as? String
                user.profileImageUrl = dictionary["ProfileImageUrl"] as? String
                
                self.userArray.append(user)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = userArray[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if let profileImageUrl = user.profileImageUrl {
            
            cell.profileImageView.loadImageCache(urlString: profileImageUrl)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}

class UserCell : UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let profileImageView : UIImageView = {
        let pi = UIImageView()
        pi.layer.cornerRadius = 24
        pi.layer.masksToBounds = true
        pi.contentMode = .scaleAspectFill
        pi.translatesAutoresizingMaskIntoConstraints = false
        return pi
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
