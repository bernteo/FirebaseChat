//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Bernard on 24/11/18.
//  Copyright © 2018 Bernard. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

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
    let registerButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsCV)
        view.addSubview(registerButton)
        
        setupInputsCV()
        setupRegisterButton()
    }
    
    func setupInputsCV() {
        inputsCV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsCV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsCV.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsCV.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupRegisterButton() {
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsCV.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsCV.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
