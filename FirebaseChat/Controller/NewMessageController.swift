//
//  NewMessageController.swift
//  FirebaseChat
//
//  Created by User on 30/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    let cellId = "cellId"
    
    var usersArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        fetchUser()
    }
    
    func fetchUser() {

        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? NSDictionary {
                let user = User()
                
                user.name = dictionary["Name"] as? String
                user.email = dictionary["Email"] as? String

                self.usersArray.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//
//        let user = usersArray[indexPath.row]
//        cell.textLabel?.text = user.name
//        cell.detailTextLabel?.text = user.email
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let user = usersArray[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email



        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
