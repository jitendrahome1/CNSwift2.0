//
//  CNConstants.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 07/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit
// Mark:- Define Functions....
let Request_User_Authenticate = 1
let Request_User_Registration = 2
let Request_Insert_New_Note = 3
let BackGroundColor = UIColor(red: 66/255, green: 133/255, blue: 244/255, alpha: 1)
let SCREEN_HEIGHT =   CGRectGetHeight(UIScreen.mainScreen().bounds)
let SCREEN_WIDTH  =    CGRectGetWidth(UIScreen.mainScreen().bounds)
let kDefaulColor =  UIColor(red: 66/255, green: 133/255, blue: 244/255, alpha: 1)
let CNWebServiceBaseURL = "https://clearnoteapp.com/account/api/";  // live
let  APIKey = "NoteTracking_2015"
let KDefultUserDetails = "userDetails"
let KDefultTimeStamp = "timeStamp"
let KDefultUserEmail  = "loginUserEmail"
let KDefultUserID    =   "loginUserID"
let cnDefult = NSUserDefaults.standardUserDefaults()

func fontWithSize(size:CGFloat)-> UIFont
{
return UIFont(name:"Futura", size:size)!
}
private let sing = NSObject()

class CNConstants: NSObject {

    
}
