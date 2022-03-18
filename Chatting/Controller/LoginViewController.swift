//
//  LoginViewController.swift
//  KIT chat
//
//  Created by 성제 on 2022/03/11.
//

import UIKit
import Firebase
class LoginViewController:UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBAction func LoginButtonPressed(_ sender: UIButton) {
        if let email = idTextField.text, let password = pwTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "loginToChat", sender: self)
                }
            }
        }
    }
}
