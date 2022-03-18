//
//  RegisterViewController.swift
//  KIT chat
//
//  Created by 성제 on 2022/03/11.
//


import UIKit
import Firebase

class RegisterViewController:UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = idTextField.text, let password = pwTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "registerToChat", sender: self)
                }
            }
        }
        
        
    }
    
    
}
