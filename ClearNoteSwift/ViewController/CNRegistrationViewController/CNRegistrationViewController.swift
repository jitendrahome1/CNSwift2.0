//
//  CNRegistrationViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 08/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNRegistrationViewController: CNBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var btnSignUP: UIButton!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var scrollBG: UIScrollView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnCrossName: UIButton!
    @IBOutlet weak var btnCrossEmail: UIButton!
    @IBOutlet weak var btnCorssPassword: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    var currentString:NSString? = ""
@IBOutlet weak var ActiveTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.btnCrossHide()
        self.registerForKeyboardNotifications()
        btnCrossName.addTarget(self, action: #selector(CNRegistrationViewController.actionCross(_:)), forControlEvents: .TouchUpInside)
        btnCrossEmail.addTarget(self, action: #selector(CNRegistrationViewController.actionCross(_:)), forControlEvents: .TouchUpInside)
        btnCorssPassword.addTarget(self, action: #selector(CNRegistrationViewController.actionCross(_:)), forControlEvents: .TouchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(CNRegistrationViewController.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
// MARK:- Userdefine functions////
    // MARK:- setUPUI
    func setupUI()
    {
        self.view.backgroundColor = BackGroundColor
        btnSignUP.layer.cornerRadius = 5.0
        
    }
    
    // mark-  ValidateFields
    func ValidateFields()->Bool
    {
        var result = true
        if(self .trim(txtUserName.text!).length == 0)
        {
            self.showMessage("", bodyMessage: "Please enter user name")
            result = false
        }
        else if(self .trim(txtEmail.text!).length == 0)
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
    func handleTap(notification:UIGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    //Mark:- Button Action
    
    @IBAction func actionBack(sender: AnyObject) {
        self.view.endEditing(true)
  //  self.dismissViewControllerAnimated(true, completion: nil)
    self.navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func actionSignUP(sender: AnyObject?) {
      self.view.endEditing(true)
        if !(self.ValidateFields())
        {
            return ;
         
        }
           self.postDataforRequestId(Request_User_Registration)
        
    
    }
    // MARK:- Cross button action.
    func actionCross(sender:UIButton)
    {
        if sender.tag == 101
        {
            self.textFieldsBlank(txtUserName)
            
        }
        else if sender.tag == 102
        {
            self.textFieldsBlank(txtEmail)
        }
            
        else if sender.tag == 103
        {
            self.textFieldsBlank(txtPassword)
        }
    }
    // MARK:- Cross Button Hide:
     func btnCrossHide()
    {
        btnCrossName.hidden = true
        btnCrossEmail.hidden = true
        btnCorssPassword.hidden = true
    }
    func textFieldsBlank(strText:UITextField)
    {
        strText.text = ""
        self.updateTextLabelsWithText(strText.text!, ptextField:strText)
    }
    func updateTextLabelsWithText(strPString:NSString, ptextField:UITextField)
    {
        
        if strPString.length > 0 && ptextField == txtUserName
        {
            btnCrossName.hidden = false
        }
        else if (!(strPString.length > 0) && ptextField == txtUserName)
        {
            btnCrossName.hidden = true
        }
        if strPString.length > 0 && ptextField == txtEmail
        {
            btnCrossEmail.hidden = false
        }
        else if (!(strPString.length > 0) && ptextField == txtEmail)
        {
            btnCrossEmail.hidden = true
        }
        if strPString.length > 0 && ptextField == txtPassword
        {
            btnCorssPassword.hidden = false
        }
        else if (!(strPString.length > 0) && ptextField == txtPassword)
        {
            btnCorssPassword.hidden = true
        }
        
    }
    // Mark: Text Field delete
    func textFieldDidBeginEditing(textField: UITextField) {    //delegate method
        ActiveTextField = textField
        
      
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {  //delegate method
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == txtUserName
        {
            txtEmail.becomeFirstResponder()
        }
        if textField == txtEmail
        {
            txtPassword.becomeFirstResponder()
        }
        if textField == txtPassword
        {
           self.actionSignUP(nil)
        }
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
    //Mark: Keybord handle
    func registerForKeyboardNotifications ()-> Void   {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CNRegistrationViewController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CNRegistrationViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    func keyboardWasShown (notification: NSNotification)
    {
        let info : NSDictionary = notification.userInfo!
        //let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
         let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        //let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height + 20, 0.0)
        if !(ActiveTextField == txtUserName)
        {
    
        let point:CGPoint = CGPointMake(0, keyboardFrame.height-40)
        scrollBG.contentOffset =  point
  
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
         let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        scrollBG.contentOffset = CGPointMake(0, 0)
         scrollBG.contentInset = contentInsets
    }
 
    // mark -
    // mark Handel Response
    func postDataforRequestId(requestId:Int!)
    {
        let emailStatus : Bool!
        // ***** workig on api Rules.....********
        
        // Mark:- 1 Store a localDataBase.
        
        
        // 2 after that update server.
        
        if requestId == Request_User_Registration     // this is only registrations.
        {
        
        emailStatus = CNDataBaseHelper.JAcheckEmailExist(txtEmail.text!)
            if emailStatus == true
            {
                // print message
              self.showMessage(txtEmail.text!, bodyMessage: "Email ID alredy exist")
            }
            else
            {
                // store into loacal database...
              CNDataBaseHelper.JAsaveRecord("1", userName: txtUserName.text!, email: txtEmail.text!, password: txtPassword.text!)
                
                let noteListController = self.storyboard?.instantiateViewControllerWithIdentifier("CNAllNotsListViewController") as! CNAllNotsListViewController
                
                cnDefult.setObject(txtEmail.text!, forKey: KDefultUserEmail)

                cnDefult.setObject("1", forKey: KDefultUserID)

                self.navigationController?.pushViewController(noteListController, animated: true)
                
                
            }
            
        }
        
        
    }
    
    func notifyRequesterWithData(responseData:AnyObject , requestId:Int)
    {
        
    }
    
}
