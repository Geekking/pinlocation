//
//  Util.swift
//  PinLocation
//
//  Created by apple on 10/10/14.
//  Copyright (c) 2014 SYSU. All rights reserved.
//

import UIKit

class DataUtil: NSObject {
    init(){
        
    }
    func JSONSerialize(objects:AnyObject!) -> (NSError?,String?){
        var str:String = ""
        var error:NSError? = nil
        return (error,str)
    }
    
    func JSONParser(jsonString:String!) -> (NSError?,AnyObject?){
        var str:String = ""
        var error:NSError? = nil
        return (error,str)
    }
    class func LoadMainTableData() -> [Trace]!{
        var traces:[Trace] = []
        var msnippet:String = "黄鹤楼" + "\n\t" + "古人吸取缓和喽，古人吸取。"
        var mlocation:Location = Location(mlongtitude:22.4,mlatitude:121.0,mlandmark:"黄鹤楼",mcity:"广州",mdescript:"古人嘉禾黄鹤楼")
        var trace  = Trace(musername:"陆游",msnippet:msnippet,mlocation:mlocation,mdatetime:11.0)
        traces.append(trace)
        return traces
    }
    
}
