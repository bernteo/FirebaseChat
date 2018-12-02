//
//  Handlers.swift
//  FirebaseChat
//
//  Created by Bernard on 1/12/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

extension LoginController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleRegister() {
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
            }
            else {
                
                guard let uid = user?.user.uid else {
                    return
                }
                
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("Profile_Images").child("\(imageName).png")
                
                if let upload = self.profileImageView.image!.pngData() {
                    
                    storageRef.putData(upload, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error!)
                        }
                        else {
                            
                            storageRef.downloadURL(completion: { (url, error) in
                                if error != nil {
                                    print(error!)
                                }
                                else {
                                    let downloadUrl = url?.absoluteString
                                    
                                    //insert "ProfileImageUrl"
                                    let values = ["Name": name, "Email": email, "ProfileImageUrl": downloadUrl]
                                    
                                    self.registerUserIntoDatabase(uid: uid, values: values as [String: AnyObject])

                                }
                            })
                        }
                    })
                }
            }
        }
    }
    //refactor out as func
    func registerUserIntoDatabase(uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference().child("Users").child(uid)
//        let values = ["Name": name, "Email": email]
        ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @objc func handleSelectProfileImageView() {
        
        let picker = UIImagePickerController()
        //needs UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //** Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        var selectedImageFromPicker : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectImage = selectedImageFromPicker {
            profileImageView.image = selectImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}


//** Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
