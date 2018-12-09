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
