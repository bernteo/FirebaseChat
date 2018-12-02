////
////  LoginController+handlers.swift
////  gameofchats
////
////  Created by Brian Voong on 7/4/16.
////  Copyright © 2016 letsbuildthatapp. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func handleRegister() {
//        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
//            print("Form is not valid")
//            return
//        }
//        
//        Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
//            
//            if let error = error {
//                print(error)
//                return
//            }
//            
//            guard let uid = res?.user.uid else {
//                return
//            }
//            
//            //successfully authenticated user
//            let imageName = NSUUID().uuidString
//            let storageRef = Storage.storage().reference().child("Profile_Images").child("\(imageName).png")
//            
//            if let upload = self.profileImageView.image!.pngData() {
//            
//            storageRef.putData(upload, metadata: nil, completion: { (metadata, error) in
//                if error != nil {
//                    print(error!)
//                }
//                else {
//
//                    storageRef.downloadURL(completion: { (url, error) in
//                        if error != nil {
//                            print(error!)
//                        }
//                        else {
//                            let downloadUrl = url?.absoluteString
//                            
//                            let values = ["Name": name, "Email": email, "ProfileImageUrl": downloadUrl]
//
//                            self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String: AnyObject])
//
//                        }
//                    })
//                }
//            })
//            }
//    
//        })
//    }
//    
//    func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
//        let ref = Database.database().reference().child("Users").child(uid)
////        let values = ["Name": name, "Email": email]
//        ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
//            
//            if let err = err {
//                print(err)
//                return
//            }
//            
//            self.dismiss(animated: true, completion: nil)
//        })
//        
//    }
//    
//
//    @objc func handleSelectProfileImageView() {
//        let picker = UIImagePickerController()
//        
//        picker.delegate = self
//        picker.allowsEditing = true
//        
//        present(picker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        // Local variable inserted by Swift 4.2 migrator.
//        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//        
//        
//        var selectedImageFromPicker: UIImage?
//        
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            selectedImageFromPicker = editedImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            
//            selectedImageFromPicker = originalImage
//        }
//        
//        if let selectedImage = selectedImageFromPicker {
//            profileImageView.image = selectedImage
//        }
//        
//        dismiss(animated: true, completion: nil)
//        
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("canceled picker")
//        dismiss(animated: true, completion: nil)
//    }
//    
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
//    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
//}
