//
//  MessageCell.swift
//  Chatr
//
//  Created by Enzo Ames on 2/24/17.
//  Copyright © 2017 Enzo Ames. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var UserLabel: UILabel!
    
    @IBOutlet weak var fetchMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        fetchMessage.preferredMaxLayoutWidth = fetchMessage.frame.size.width
    }

//    override func layoutSubviews()
//    {
//        fetchMessage.preferredMaxLayoutWidth = fetchMessage.frame.size.width
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
