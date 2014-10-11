//
//  Trace.swift
//  PinLocation
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit

class Trace: NSObject {
    var username:String!  = "luyou"
    var datetime:Double!
    var snippet:String!   = "良辰美景"
    var location:Location?
    
    init(musername:String!,msnippet:String!,mlocation:Location?,mdatetime:Double?){
        self.username = musername
        self.snippet = msnippet
        self.location = mlocation
        if mdatetime{
            self.datetime = mdatetime!
        }else{
            let timestamp = NSDate().timeIntervalSince1970;
            self.datetime = timestamp
        }
        
    }
    
}
