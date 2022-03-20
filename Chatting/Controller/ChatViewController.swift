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
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessage()
    }
    
    var message: [Chat] = []
    
    func loadMessage() {
        
        db.collection("message").order(by: "date").addSnapshotListener{ (querySnapshot, error) in
            self.message = []
            if let e = error {
                print(e)
            } else {
                if let snapShot = querySnapshot?.documents {
                    for doc in snapShot {
                        let data = doc.data()
                        if let messageSender = data["name"] as? String, let messageBody = data["body"] as? String  {
                            let newMessage = Chat(name: messageSender, body: messageBody)
                            self.message.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
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
            db.collection("message").addDocument(data: ["name": messageSender, "body": messageBody, "date" : Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Success")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
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
        let message = message[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.textLabel?.text = message.body
        
        if message.name == Auth.auth().currentUser?.email {
            cell.leftView.isHidden = true
            cell.rightView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: "BrandLightPurple")
            cell.label.textColor = UIColor(named: "BrandPurple")
        }
        
        return cell
    }
    
}
