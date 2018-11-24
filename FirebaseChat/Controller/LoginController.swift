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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsCV)
        
        setupInputsCV()
    }
    
    func setupInputsCV() {
        inputsCV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsCV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsCV.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsCV.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    ≥
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
