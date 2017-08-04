//
//  CNChangePasswordViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 08/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNChangePasswordViewController: CNBaseViewController {

    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var scrollBG: UIScrollView!
    @IBOutlet weak var btnCrossCurrPass: UIButton!
    
    @IBOutlet weak var btnCrossNewPass: UIButton!
    
    @IBOutlet weak var btnCrossCofiPass: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK:- Button Action
    
    @IBAction func actionBack(sender: AnyObject) {
      self.navigationController?.popViewControllerAnimated(true)
    }
    
  
    @IBAction func actionSave(sender: AnyObject) {
    }
    
    //Mark:- User Define function
    
    
  
}
