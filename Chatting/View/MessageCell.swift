//
//  MessageCell.swift
//  KIT chat
//
//  Created by 성제 on 2022/03/16.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var rightView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 3
    }
    
}
