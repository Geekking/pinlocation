//
//  MainTableViewCell.swift
//  PinLocation
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet var username: UIButton
    @IBOutlet var portrait: UIImageView
    @IBOutlet var snippet: UITextView
    @IBOutlet var date: UILabel
    @IBOutlet var landmarkBtn: UIButton
    @IBOutlet var goodBtn: UIButton
    @IBOutlet var commentBtn: UIButton

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    func config(trace:Trace!) {
        self.username.titleLabel.text = trace.username
        self.snippet.text = trace.snippet
        self.landmarkBtn.titleLabel.text = trace.location.landmark
        self.date.text = "公元211年"
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func usernameTabbed(sender: AnyObject) {
        println("tab on username")
    }

    @IBAction func landmarkTabbed(sender: AnyObject) {
        println("tab on landmark")
    }
    @IBAction func goodTabbed(sender: AnyObject) {
        println("tab on good btn")
    }
    @IBAction func commentTabbed(sender: AnyObject) {
        println("tab on  comment")
    }
    
}
