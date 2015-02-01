//
//  CommentCell.swift
//  EventHype
//
//  Created by Zachary Feinn on 1/31/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet var messageText: UILabel!
    @IBOutlet var timeSincePost: UILabel!
    @IBOutlet var numReplies: UILabel!
    @IBOutlet var numVotes: UILabel!
}
