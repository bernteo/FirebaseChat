//
//  Handlers.swift
//  FirebaseChat
//
//  Created by Bernard on 9/12/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

extension LoginController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleRegister() {
        //UPLOAD
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {
            (user, error) in
            
            if error != nil {
                print(error!)
            }
            else {
                
                guard let uid = user?.user.uid else {
                    return
                }
                //UPLOAD IMAGES
                let image = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("Profile_Images").child("\(image).jpg")
                
                if let upload = self.profileImage.image?.jpegData(compressionQuality: 0.1) {
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
                                    
                                    if let downloadUrl = url?.absoluteString {
                                        let values = ["Name": name, "Email": email, "ProfileImageUrl": downloadUrl]
                                        self.registerUserIntoDBWithUid(uid: uid, values: values as [String : AnyObject])
                                    }
                                }
                            })
                        }
                    })
                }
            }
        }
    }
    
    func registerUserIntoDBWithUid(uid: String, values: [String: AnyObject]) {
        //UPLOAD DATA
        let ref = Database.database().reference().child("Users").child(uid)
//        let values = ["Name": name, "Email": email]
        ref.updateChildValues(values, withCompletionBlock: {
            (err, ref) in
            if err != nil {
                print(err!)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    @objc func handleProfileImageView() {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectImagePicker : UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectImagePicker = editedImage
        }
        else if let originalImage = info[.originalImage] as? UIImage {
            selectImagePicker = originalImage
        }
        
        if let selectImage = selectImagePicker {
            profileImage.image = selectImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
