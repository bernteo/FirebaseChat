//
//  Handlers.swift
//  FirebaseChat
//
//  Created by Bernard on 9/12/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit

extension LoginController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleProfileImageView() {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
        
    }
    
}
