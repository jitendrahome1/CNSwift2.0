//
//  CNLoginViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 07/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNLoginViewController: CNBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnCrossEmail: UIButton!
    
    @IBOutlet weak var btnCrossPassword: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    var currentString:NSString? = ""
    
    
    @IBOutlet weak var ScrollBG: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCrossEmail.addTarget(self, action: #selector(CNLoginViewController.buttonAction(_:)), forControlEvents: .TouchUpInside)
        btnCrossPassword.addTarget(self, action: #selector(CNLoginViewController.buttonAction(_:)), forControlEvents: .TouchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CNLoginViewController.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        self.btnCrossHide()
        self.setupUI()
        [self .registerForKeyboardNotifications()]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
     }
    
    // MARK: Button Action
    @IBAction func actionBack(sender: AnyObject) {
        self.view.endEditing(true)
       // self.dismissViewControllerAnimated(false, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func actionSignIn(sender: AnyObject) {
    self.view.endEditing(true)
        if !(self.ValidateFields())
        {
            print(" some thing is missing")
            return;
        }
    self.postDataforRequestId(Request_User_Authenticate)
    }
    
    @IBAction func actionForgotPassword(sender: AnyObject) {
    }
    
    func buttonAction(sender:UIButton!)
    {
        if sender.tag == 101
        {
            txtEmail.text = ""
            self .updateTextLabelsWithText(txtEmail.text!, ptextField: txtEmail)
        }
        else
        {
            txtPassword.text = ""
            self .updateTextLabelsWithText(txtPassword.text!, ptextField: txtPassword)
        }
    }
    
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
                self.updateTextLabelsWithText(currentString! , ptextField: textField)
            }
            else
            {
                currentString = ""
                self.updateTextLabelsWithText(currentString! , ptextField: textField)
            }
            
        }
        return true
    }
    
    // MArk: User Define Functions
    func btnCrossHide()
    {
        btnCrossEmail.hidden = true
        
        btnCrossPassword.hidden = true
    }
    
    func updateTextLabelsWithText( strPString:NSString, ptextField:UITextField )
    {
        print(strPString);
        if strPString.length > 0 && ptextField == txtEmail
        {
            btnCrossEmail.hidden = false
        }
        else if (!(strPString.length > 0) && ptextField == txtEmail)
        {
            btnCrossEmail.hidden = true
        }
        else if (strPString.length > 0 && ptextField == txtPassword)
        {
            btnCrossPassword.hidden = false
        }
        else if !(strPString.length > 0 && ptextField == txtPassword)
        {
            btnCrossPassword.hidden = true
        }
        
    }
    // mark-  ValidateFields
    func ValidateFields()->Bool
    {
        var result = true
        if(self .trim(txtEmail.text!).length == 0)
        {
            self.showMessage("", bodyMessage: "Please enter your email address")
            result = false
        }
        if(self .trim(txtPassword.text!).length == 0)
        {
            self.showMessage("", bodyMessage: "Please enter your password")
            result = false
        }
        if !(CNBaseViewController.isValidEmail(self.trim(txtEmail.text!) as String))
        {
            self.showMessage("", bodyMessage: "Please enter Correct Email")
            result = false
            
        }
        
        return result;
    }
    func keyboardWasShown (notification: NSNotification)
    {
        if SCREEN_HEIGHT <= 480
        {
            ScrollBG .setContentOffset(CGPointMake(0, 75), animated: true)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //ScrollBG.contentInset = UIEdgeInsetsMake(0, 0, 0,0 );
        ScrollBG.contentOffset = CGPointMake(0, 0);
        
    }
    //Mark: Keybord handle
    func registerForKeyboardNotifications ()-> Void   {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CNLoginViewController.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CNLoginViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil)
    {
        self.view.endEditing(true)
    }
    
    // Mark:- setUpUI
    func setupUI()
    {
       
        txtEmail.text = "jitu@gmail.com"
        txtPassword.text = "123456"
        btnSignIn.layer.cornerRadius = 5.0;
        self.view.backgroundColor = BackGroundColor; 
        
    }
    
    // MARK:- API Functions
    
    // Mark :-  Login Api
    
//    func loginAPI()
//    {
//        
//    CNRequestController.sharedInstance.CNRequestAuthenticateUserWithEmail(txtEmail.text!, password: txtPassword.text!, success: { (responseDict) -> Void in
//        let dict = responseDict as! NSDictionary
//        print(dict)
//        let ResponseCode = dict["ResponseCode"]?.integerValue
//        if ResponseCode == 200
//        {
//            cnDefult.setObject(dict, forKey: KDefultUserDetails)
//            
//            self.getAllNotes({ (arrData) -> Void in
//                
//               
//                
//                    let noteListVC  = self.storyboard?.instantiateViewControllerWithIdentifier("CNAllNotsListViewController") as! CNAllNotsListViewController
//                    noteListVC.arrNoteList = arrData
//                    self.navigationController?.pushViewController(noteListVC, animated: true)
//               
//                
//            })
//            
//        }
//        
//        })
//        { (operation, error) -> Void in
//            
//        }
//    }
    
//    // MARK: - GEt all notes.
//    func getAllNotes(sucess:(arrData:NSArray?)->Void)
//    {
//        let date = NSDate()
//    let userID = cnDefult.objectForKey(KDefultUserDetails) as! NSDictionary
//        CNRequestController.sharedInstance.CNRequestGetAllNoteListWithUserID(userID["userId"] as! NSString, timestamp:"0", currentTimestamp: date.gettimestampStringFroLocalTime(), DeviceID: "jjdhsfjhsdjjsgdsdghgsd", success: { (responseDict) -> Void in
//            print("note List \(responseDict)")
//             //let dict = responseDict["ResponseCode"] as? NSString
//            cnDefult.setObject(responseDict["TimeStamp"], forKey: KDefultTimeStamp)
//            
//            let arrNoteList:NSArray? = responseDict["noteList"] as? NSArray
//            sucess(arrData:arrNoteList)
//            })
//            { (operation, error) -> Void in
//            
//        }
//        
//        
//    }
    
    
    // mark -
    // mark Handel Response
    func postDataforRequestId(requestId:Int!)
    {

        if requestId == Request_User_Authenticate     // this is only registrations.
        {
            let getResult : NSArray? = CNDataBaseHelper.JAauthenticateUsers(txtEmail.text!, password: txtPassword.text!)
            
            if getResult?.count > 0
            {
                let objUsers  = getResult![0] as! Users
            
                print("user email \(objUsers.userName!)")
                let cnNoteListVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNAllNotsListViewController") as! CNAllNotsListViewController
                cnDefult.setObject(objUsers.email, forKey: KDefultUserEmail)
                self.navigationController?.pushViewController(cnNoteListVC, animated: true)
                
                
            }
            else
            {
                self.showMessage("", bodyMessage: "Authenticate Error!")
                
            }
            
            
        
        }
        
        
    }
    
    func notifyRequesterWithData(responseData:AnyObject , requestId:Int)
    {
        
    }

    
}
