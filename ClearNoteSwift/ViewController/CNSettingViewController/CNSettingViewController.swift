//
//  CNSettingViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 10/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNSettingViewController: CNBaseViewController {
    
    var arrcellIdentifier:NSArray = ["cell1","cell2","cell3","cell4","cell5","cell6"]
    var strUserEmail:NSString?
    @IBOutlet weak var tblSetting: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "All Notes"
        navigationItem.hidesBackButton = true
        
        self.setupUI()
        
    }
    
    // MARK:- setupUI
    func setupUI()
    {
        navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.translucent = false;
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes = ([NSFontAttributeName: fontWithSize(16),NSForegroundColorAttributeName: kDefaulColor])
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CNSettingViewController.actionDone))
        self.navigationItem.leftBarButtonItems = [doneBtn]
        navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: fontWithSize(16),NSForegroundColorAttributeName: kDefaulColor], forState: UIControlState.Normal)
        
        
        
    
        
    }
    // MARK:- user Define function
    
    // Mark: - Done Btn Action/
    func actionDone()
    {
        // done btn action/s
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    // MARK:- table View Delate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 99.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = arrcellIdentifier[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier as! String , forIndexPath: indexPath) as! CNSettingCell
        cell.btnChangePassword?.addTarget(self, action: #selector(CNSettingViewController.actionChangePassword(_:)), forControlEvents: .TouchUpInside)
        cell.btnTrash?.addTarget(self, action: #selector(CNSettingViewController.actionTrash(_:)), forControlEvents: .TouchUpInside)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        self.makeCornerUI(cell.btnTrash, pImage: nil)
        self.makeCornerUI(cell.btnChangePassword, pImage: nil)
        self.makeCornerUI(nil, pImage: cell.imageTxtBG)
     strUserEmail = cnDefult.objectForKey(KDefultUserEmail)  as? NSString
        print("Email is \(strUserEmail!)")
        
       if cellIdentifier as! String == "cell5"
       {
        if let email = strUserEmail
        {
            cell.lblLoginEmail.text = email as String
        }
        
        }

        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // Mark:-
    func makeCornerUI(pButton:UIButton!, pImage:UIImageView!)
    {
        if let cusButton = pButton
        {
            cusButton.layer.cornerRadius = 5.0
            cusButton.layer.borderWidth = 1.0
            cusButton.layer.borderColor = kDefaulColor.CGColor
        }
        else if let img = pImage
        {
            img.layer.cornerRadius = 5.0
            img.layer.borderWidth = 1.0
            img.layer.borderColor = kDefaulColor.CGColor
            
            
        }
    }
    // Button Action.
    func actionChangePassword(sender:UIButton!)
    {
        let changePasswordVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNChangePasswordViewController") as! CNChangePasswordViewController
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
    }
    
    func actionTrash(sender:UIButton!)
    {
        let trashVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNTrashViewController") as! CNTrashViewController
        self.navigationController?.pushViewController(trashVC, animated: true)
    }
    
}
