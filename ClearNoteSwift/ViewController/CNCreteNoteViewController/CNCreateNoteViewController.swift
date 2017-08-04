//
//  CNCreateNoteViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 08/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNCreateNoteViewController: CNBaseViewController,UITextFieldDelegate, UITextViewDelegate {

    // Mark:- variables
    
    @IBOutlet weak var txtNoteTitle: UITextField!
    @IBOutlet weak var btnCrossNoteTitle: UIButton!
    let date = NSDate();
    @IBOutlet weak var scrollBG: UIScrollView!
    
    @IBOutlet weak var viewBG: UIView!
    var backBtn:UIBarButtonItem!
    var actionButtonItems:NSArray!
    var shareBtn:UIBarButtonItem!
     var currentString:NSString? = ""
    var strTextView:NSString?
 
    @IBOutlet weak var txtArea: UITextView!
    
    @IBOutlet weak var lblPlaceHolder: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.crossBtnHideUnhide(self.trim(txtNoteTitle.text!))
   txtNoteTitle.becomeFirstResponder()
     self.registerForKeyboardNotifications();   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }

    // func setupUI
    func setupUI()
    {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController!.navigationBar.translucent = false;
        
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
        
        backBtn = UIBarButtonItem(image: UIImage(named:"ArrowNotsiPhone.png"), style:UIBarButtonItemStyle.Plain, target: self, action: Selector("noteSave"))
        self.navigationItem.leftBarButtonItem = backBtn
        self.SettingtUpBarButtonItems()
        btnCrossNoteTitle.addTarget(self, action: #selector(CNCreateNoteViewController.actionCrossBtn), forControlEvents: .TouchUpInside)
    }
    func SettingtUpBarButtonItemOnly()
    {
        self.SettingtUpBarButtonItems()
        self.navigationItem.rightBarButtonItems = nil
        let button = UIButton()
        button.frame = CGRectMake(0, 0, 44, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, -40)
        button.setImage(UIImage(named: "hareHeaderIconiPhone.png"), forState: .Normal)
        button.addTarget(self, action: #selector(CNCreateNoteViewController.shareBtnAction), forControlEvents: .TouchUpInside)
        shareBtn.customView = button
        self.navigationItem.rightBarButtonItems = [shareBtn]
        
        
    }
    func SettingtUpBarButtonItems()
    {
        let shareButton = UIButton()
        shareButton.frame = CGRectMake(0, 0, 44, 44)
        shareButton.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, -20)
        shareButton.setImage(UIImage(named:"ShareHeaderIconiPhone.png"), forState:.Normal)
        shareButton.addTarget(self, action: #selector(CNCreateNoteViewController.shareBtnAction), forControlEvents: .TouchUpInside)
        let share_Btn = UIBarButtonItem()
        share_Btn.customView = shareButton
        
        let keyboardHideButton = UIButton()
        keyboardHideButton.frame = CGRectMake(0, 0, 44, 44)
        keyboardHideButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25)
        keyboardHideButton.setImage(UIImage(named:"KeyboardHeaderIconiPhone.png"), forState:.Normal)
        keyboardHideButton.addTarget(self, action: #selector(CNCreateNoteViewController.keyApperBtnAction), forControlEvents: .TouchUpInside)
        let keyApper_Btn = UIBarButtonItem()
        keyApper_Btn.customView = keyboardHideButton
        //actionButtonItems = [keyApper_Btn,shareButton]as NSArray
         self.navigationItem.rightBarButtonItems = [keyApper_Btn,share_Btn]
        //self.navigationItem.setRightBarButtonItems(actionButtonItems! as? [UIBarButtonItem], animated: true)
        
    }
    // MARK:- Note SAVE
//    func noteSave()
//    {
//        let userID = cnDefult.objectForKey(KDefultUserDetails) as! NSDictionary
//       
//        
//        
//       // CNRequestController.sharedInstance.CNRequestCreateNoteWithUserID(userID["userId"]as! NSString, noteTitle: txtNoteTitle.text!, content: txtArea.text, createDateTime: date.gettimestampStringFroLocalTime(), isDelete: "0", isSynchronise: "0", success: { (responseDict) -> Void in
//            let dict = responseDict as? NSDictionary
//            
//            print("creted note \(responseDict)")
//            let ResponseCode = dict?.valueForKey("ResponseCode")?.integerValue
//            if ResponseCode == 200
//            {
//                // back and save.
//                self.navigationController?.popViewControllerAnimated(true)
//                
//            }
//       
//            })
//            { (operation, error) -> Void in
//            
//        }
//       
//        
//        
//    }
    
    // MARK:- Note SAVE
       func noteSave()
       {
        self.view.endEditing(true)
        if !(self.ValidateFields())
        {
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        else
        {
            self.postDataforRequestId(Request_Insert_New_Note)
           
            
        }
    }
    // mark-  ValidateFields
    func ValidateFields()->Bool
    {
        var result = true
        if(self .trim(txtNoteTitle.text!).length == 0 && self.trim(txtArea.text!).length == 0)
        {
            
            result = false
        }
        else if(self .trim(txtNoteTitle.text!).length == 0)
        {
           txtNoteTitle.text! = "Note"
            result = true
        }
        else if(self .trim(txtArea.text!).length == 0)
        {
            currentString = ""
            result = true
        }
        return result;
    }

    func keyApperBtnAction()
    {
        self.view.endEditing(true)
    }
    func shareBtnAction()
    {
        print("share actions")
    }
    func crossBtnHideUnhide(pstr:NSString)
    {
        if pstr.length > 0
        {
            btnCrossNoteTitle.hidden = false
        }
        else
        {
            btnCrossNoteTitle.hidden = true
        }
    }
    func actionCrossBtn()
    {
        txtNoteTitle.text = ""
        self.crossBtnHideUnhide(self.trim(txtNoteTitle.text!))
        self.txtNoteTitle.becomeFirstResponder()
    }
    // MARK:- 
    // Mark: Text Field delete
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
    
        
        
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        currentString = textField.text

        if ((textField.text) != nil)
        {
            currentString = currentString!.stringByReplacingCharactersInRange(range, withString: string)
            
            if currentString?.length > 0
            {
                self.crossBtnHideUnhide(self.trim(currentString!))
            }
            else
            {
                currentString = ""
                 self.crossBtnHideUnhide(self.trim(currentString!))
            }
            
        }

        return true
    }
    // mark- Text View Delegate
 func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    
    strTextView = textView.text
    strTextView = strTextView?.stringByReplacingCharactersInRange(range, withString: text)
    print(strTextView!)
    if self.trim(strTextView!).length == 0
    {
        lblPlaceHolder.hidden = false
    }
    else
    {
        lblPlaceHolder.hidden = true
        
    }
    
    return true
    
    }
    
    func textViewDidBeginEditing(textView: UITextView) {    //delegate method
    
    }
    func keyboardWasShown (notification: NSNotification)
    {
        let info : NSDictionary = notification.userInfo!
        //let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, -4.0)
        txtArea.contentInset = contentInsets
        txtArea.scrollIndicatorInsets = contentInsets
    }
    func keyboardWillBeHidden(notification: NSNotification)
    {
        self.navigationItem.rightBarButtonItems = nil
        self.navigationItem.rightBarButtonItem = shareBtn
         let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0,0.0, -4.0)
        txtArea.contentInset = contentInsets
        txtArea.scrollIndicatorInsets = contentInsets

    }
    func registerForKeyboardNotifications ()-> Void   {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CNCreateNoteViewController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CNCreateNoteViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // mark -
    // mark Handel Response
    func postDataforRequestId(requestId:Int!)
    {
        
        if requestId == Request_Insert_New_Note     // this is only new note registrations.
        {
            CNDataBaseHelper.JAInsertNewNoteWithUserID("1", noteID: "201", noteName: txtNoteTitle.text!, noteData: txtArea.text!, noteCreatedDate: date.gettimestampStringFroLocalTime(), isDelete: "0", isSynchoronization: "0", tempUserID: date.gettimestampStringFroLocalTime())
               self.navigationController?.popViewControllerAnimated(true)
    
        }
    }
    
    func notifyRequesterWithData(responseData:AnyObject , requestId:Int)
    {
        
    }
  

}
