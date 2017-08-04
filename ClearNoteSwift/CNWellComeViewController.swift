//
//  ViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 07/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNWellComeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = BackGroundColor;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Button Actions.
    
    @IBAction func ActionSignInWithAccount(sender: AnyObject) {
        
        
        let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNLoginViewController") as! CNLoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated: true)
    
       //self.navigationController?.presentViewController(loginVC, animated: true, completion: nil)
    
    
    
    }
   
    @IBAction func ActionSignUpWithEmail(sender: AnyObject) {
        
      let registrationVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNRegistrationViewController")as! CNRegistrationViewController
               self.navigationController?.pushViewController(registrationVC, animated: true)
        //self.navigationController?.presentViewController(registrationVC, animated: true, completion: nil)
    }
}

