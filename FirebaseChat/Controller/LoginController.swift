//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Bernard on 24/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit
import Firebase

class LoginController : UIViewController {

    //inputsCV : UIView!
    let inputsCV : UIView = {
        let ivc = UIView()
        ivc.backgroundColor = UIColor.white
        ivc.layer.cornerRadius = 5
        ivc.layer.masksToBounds = true
        ivc.translatesAutoresizingMaskIntoConstraints = false
        return ivc
    }()
    
    //registerButton : UIButton!
    let loginRegisterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleRegister() {
        
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
         
                let ref = Database.database().reference().child("Users")
                let values = ["Name": name, "Email": email]
                ref.updateChildValues(values, withCompletionBlock: {
                    (err, ref) in
                    if err != nil {
                        print(err!)
                    }
                    else {
                        print("Saved User in DB")
                    }
                })
            }
        }
    }
    
    //textField : UITextField!
    let nameTextField : UITextField = {
       let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator : UIView = {
        let ns = UIView()
        ns.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
    
    //textField : UITextField!
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator : UIView = {
        let ns = UIView()
        ns.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
    
    //textField : UITextField!
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //profileImage : UIImageView!
    let profileImage : UIImageView = {
        let pi = UIImageView()
        pi.image = UIImage(named: "profile icon")
        pi.translatesAutoresizingMaskIntoConstraints = false
        return pi
    }()
    
    //segmentedControl : UISegmentedControl!
    let loginRegisterSegmentedControl : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        inputsCVHeightA?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameTextFieldHeightA?.isActive = false
        nameTextFieldHeightA = nameTextField.heightAnchor.constraint(equalTo: inputsCV.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightA?.isActive = true
        
        emailTextFieldHeightA?.isActive = false
        emailTextFieldHeightA = emailTextField.heightAnchor.constraint(equalTo: inputsCV.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightA?.isActive = true
        
        passwordTextFieldHeightA?.isActive = false
        passwordTextFieldHeightA = passwordTextField.heightAnchor.constraint(equalTo: inputsCV.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightA?.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsCV)
        view.addSubview(profileImage)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(loginRegisterButton)
        
        setupProfileImage()
        setupInputsCV()
        setupRegisterButton()
        setupLoginRegisterSC()
    }
    
    func setupProfileImage() {
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupLoginRegisterSC() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsCV.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    var inputsCVHeightA : NSLayoutConstraint?
    var nameTextFieldHeightA : NSLayoutConstraint?
    var emailTextFieldHeightA : NSLayoutConstraint?
    var passwordTextFieldHeightA : NSLayoutConstraint?

    
    func setupInputsCV() {
        inputsCV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsCV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsCV.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        inputsCVHeightA = inputsCV.heightAnchor.constraint(equalToConstant: 150)
        inputsCVHeightA?.isActive = true
        
        view.addSubview(nameTextField)
        view.addSubview(nameSeparator)
        view.addSubview(emailTextField)
        view.addSubview(emailSeparator)
        view.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsCV.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsCV.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        
        nameTextFieldHeightA = nameTextField.heightAnchor.constraint(equalTo: inputsCV.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightA?.isActive = true
        
        nameSeparator.leftAnchor.constraint(equalTo: inputsCV.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsCV.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        
        emailTextFieldHeightA = emailTextField.heightAnchor.constraint(equalTo: inputsCV.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightA?.isActive = true
        
        emailSeparator.leftAnchor.constraint(equalTo: inputsCV.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsCV.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        
        passwordTextFieldHeightA = passwordTextField.heightAnchor.constraint(equalTo: inputsCV.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightA?.isActive = true
        
    }
    
    func setupRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsCV.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension UIColor {
        convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
            self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        }
}
