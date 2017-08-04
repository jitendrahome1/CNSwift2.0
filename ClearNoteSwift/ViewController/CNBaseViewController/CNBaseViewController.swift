//
//  CNBaseViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 07/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  // mark- validate email
    class func isValidEmail(testStr:String) -> Bool {
        print("validate email: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
// Mark:- Remove Space.
    
    func trim(pdata:NSString)->NSString
    {
        return pdata.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    // Mark: show alert
    
    func showMessage(title:NSString, bodyMessage:NSString)
    {
        let actionSheetController: UIAlertController = UIAlertController(title:title as String, message:bodyMessage as NSString as String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        actionSheetController.addAction(defaultAction)
        
        presentViewController(actionSheetController, animated: true, completion: nil);
    }
    // Mark:- Corner Redies
    

}
