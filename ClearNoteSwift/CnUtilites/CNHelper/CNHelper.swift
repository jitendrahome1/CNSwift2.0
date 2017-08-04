//
//  CNHelper.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 13/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNHelper: NSObject {
    var CNBaseURL:NSString?
    class var sharedInstance: CNHelper {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CNHelper? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = CNHelper()
        }
        return Static.instance!
    }
    
    
}
