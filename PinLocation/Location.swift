//
//  Location.swift
//  PinLocation
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit

class Location: NSObject {
    var longtitude:Double = 12.0
    var latitude:Double   = 10.0
    var introduction:String?
    var city:String       = "GuangZhou"
    var landmark:String   = "zhujian new town"
    init(mlongtitude:Double,mlatitude:Double,mlandmark:String,mcity:String,mdescript:String?) {
        self.longtitude = mlongtitude
        self.latitude   = mlatitude
        self.landmark   = mlandmark
        self.city       = mcity
        if mdescript {
            self.introduction = mdescript!
        }
    }
    
}
