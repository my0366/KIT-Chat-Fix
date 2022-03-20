//
//  MessageCell.swift
//  KIT chat
//
//  Created by 성제 on 2022/03/16.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var leftView: UIImageView!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
