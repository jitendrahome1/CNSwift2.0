//
//  NSDate+Extra.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 09/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit
extension NSDate {
    func stringFromDate()->NSString
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
       return dateFormatter.stringFromDate(self)
    }
    
    // Mark :- get timestampStringFroLocalTime
     func gettimestampStringFroLocalTime()->NSString
    {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss"
        let currentDateString:NSString = dateFormatter.stringFromDate(NSDate())
        let formatterForCurrentDate = NSDateFormatter()
        formatterForCurrentDate.dateFormat = "dd/MM/yy HH:mm:ss"
        let gmt:NSTimeZone = NSTimeZone(abbreviation: "GMT")!
        formatterForCurrentDate.timeZone = gmt
        let currentDate1:NSDate = formatterForCurrentDate.dateFromString(currentDateString as String)!
        let milliseconds:CLongLong = CLongLong((currentDate1.timeIntervalSince1970))
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
        }
    // MArk :-  timestamp to date
    
    func timestampTodate(ptimeStamp:NSString)->NSString
    {
        //let timeStampString: String = ptimeStamp as String
        let _interval: NSTimeInterval = ptimeStamp.doubleValue
        let date: NSDate = NSDate(timeIntervalSince1970: _interval)
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss"
        let formatterForCurrentDate: NSDateFormatter = NSDateFormatter()
        formatterForCurrentDate.dateFormat = "dd/MM/yy HH:mm:ss"
        let gmt: NSTimeZone = NSTimeZone(abbreviation: "GMT")!
        formatterForCurrentDate.timeZone = gmt
        let formattedDate: String = formatterForCurrentDate.stringFromDate(date)
        return formattedDate
    }
    
    func TimeAMPMWithData(pData:NSString)->NSString
    {
     
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss"
        let formatterForCurrentDate: NSDateFormatter = NSDateFormatter()
        formatterForCurrentDate.dateFormat = "dd/MM/yy HH:mm:ss"
        let gmt: NSTimeZone = NSTimeZone(abbreviation: "GMT")!
        formatterForCurrentDate.timeZone = gmt
         let date: NSDate = formatterForCurrentDate.dateFromString(self.timestampTodate(pData) as String)!
        formatterForCurrentDate.dateFormat = "hh:mma"
        let formattedDate: String = formatterForCurrentDate.stringFromDate(date).lowercaseString
        return formattedDate
    }
    
    // Mark :-  get Date
    
    func datefetch(let ptimeStamp:NSString)->NSString
    {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss"
        
       let currentDateString:NSString = "14/06/16 17:17:52"
        
        print("time \(currentDateString)")
        let formatterForCurrentDate: NSDateFormatter = NSDateFormatter()
        formatterForCurrentDate.dateFormat = "dd/MM/yy HH:mm:ss"
        let gmt: NSTimeZone = NSTimeZone(abbreviation: "GMT")!
        formatterForCurrentDate.timeZone = gmt
        print(ptimeStamp as String!)
   
        let date: NSDate = formatterForCurrentDate.dateFromString(self.timestampTodate(ptimeStamp) as String)!
        formatterForCurrentDate.dateFormat = "dd/MM/yy"
        let formattedDate: String = formatterForCurrentDate.stringFromDate(date).lowercaseString
        return formattedDate
       
    }
    
}
