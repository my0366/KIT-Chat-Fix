//
//  ChatViewController.swift
//  KIT chat
//
//  Created by 성제 on 2022/03/12.
//

import UIKit
import Firebase

class ChatViewController:UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "KIT Chat"
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "ReusableCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
    }
    
    var message: [Chat] = []
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("SignOut Error %@", signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("message").addDocument(data: ["name":messageSender,"body": messageBody]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Success")
                }
            }
        }
    }
    
    
}

extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Message", for: indexPath) as! MessageCell
        cell.textLabel?.text = message[indexPath.row].name
        return cell
    }
    
}
