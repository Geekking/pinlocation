//
//  MainTableViewCell.swift
//  PinLocation
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet var username: UIButton
    @IBOutlet var protrait: UIImageView
    
    @IBOutlet var snippet: UITextView
    @IBOutlet var commentBtn: UIButton
    @IBOutlet var goodBtn: UIButton
    @IBOutlet var landmark: UIButton
    @IBOutlet var date: UILabel
    
    var trace:Trace?
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    func config(trace:Trace!) {
        self.username.setTitle(trace.username, forState: UIControlState.Normal)
        self.snippet.text = trace.snippet
        
        //TODO: add no location handler
        self.landmark.setTitle(trace.location?.landmark, forState: UIControlState.Normal)
        self.date.text = "公元211年"
        self.protrait.image = UIImage(named: "avatar.png")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.config(self.trace!)
       
    }
    
    @IBAction func usernameTabbed(sender: AnyObject) {
        println("tab on username button")
        println("\(self.tag)")
    }
    
    @IBAction func landmarkTabbed(sender: AnyObject) {
    }
    

    @IBAction func goodBtnTabbed(sender: AnyObject) {
    }
    
    @IBAction func commentBtnTabbed(sender: AnyObject) {
        
    }
}
