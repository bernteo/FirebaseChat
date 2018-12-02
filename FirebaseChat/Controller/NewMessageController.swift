//
//  NewMessageController.swift
//  gameofchats
//
//  Created by Brian Voong on 6/29/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                
                user.name = dictionary["Name"] as? String
                user.email = dictionary["Email"] as? String
                //** need to insert url to user in order to display in tableView below
                user.profileImageUrl = dictionary["ProfileImageUrl"] as? String
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
                self.users.append(user)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                     self.tableView.reloadData()
                })
                
                //                user.name = dictionary["name"]
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        //** as! to unwrapped UserCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
//        cell.imageView?.image = UIImage(named: "nedstark")
//        cell.imageView?.contentMode = .scaleAspectFill
        
        if let profileImageUrl = user.profileImageUrl {
            //** URL instead of NSURL
            let url = URL(string: profileImageUrl)
            //** URL shared datTask instead of NSURLSession sharedSession dataTaskWithURL
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
            
                if error != nil {
                    print(error!)
                }
                else {
                    
                    DispatchQueue.main.async(execute: {
//                        cell.imageView?.image = UIImage(data: data!)
                        cell.profileImageView.image = UIImage(data: data!)
                    })
                }
            }).resume()
        }
        return cell
    }
}

class UserCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)

    }
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nedstark")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}








