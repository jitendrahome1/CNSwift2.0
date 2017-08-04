//
//  CNNoteDescriptionsViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 13/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNNoteDescriptionsViewController: CNBaseViewController  {
    var backBtn:UIBarButtonItem!
    var shareBtn:UIBarButtonItem!
    var _objMaster : MasterNote!
    var istextEdit : Bool!
    var strTextField : NSString!
    var strTextView  : NSString!
    var strNoteId : NSString!
    var visibleIndexPath : NSIndexPath!
    var arrNoteItems : NSMutableArray!
    let date = NSDate();
    @IBOutlet weak var collectionsDetils: UICollectionView!
    var arrAllNoteList:NSArray!

       var pageIndex : NSInteger!
    @IBOutlet weak var btnTrash: UIButton!
    
    @IBOutlet weak var lblCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    visibleIndexPath = NSIndexPath(forRow: pageIndex! ,  inSection: 0 )
    arrNoteItems = NSMutableArray();
    arrNoteItems.addObjectsFromArray(arrAllNoteList as [AnyObject])
        istextEdit = false
       self.setupUI()
        self.noteDisplayWithIndexPath(pageIndex)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    func setupUI()
    {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController!.navigationBar.translucent = false;
        
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
        
        backBtn = UIBarButtonItem(image: UIImage(named:"ArrowNotsiPhone.png"), style:UIBarButtonItemStyle.Plain, target: self, action: #selector(CNNoteDescriptionsViewController.noteSave))
        self.navigationItem.leftBarButtonItem = backBtn
        self.SettingtUpBarButtonItems()
    }
    func SettingtUpBarButtonItemOnly()
    {
        self.SettingtUpBarButtonItems()
        self.navigationItem.rightBarButtonItems = nil
        let button = UIButton()
        button.frame = CGRectMake(0, 0, 44, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, -40)
        button.setImage(UIImage(named: "hareHeaderIconiPhone.png"), forState: .Normal)
        button.addTarget(self, action: Selector("shareBtnAction"), forControlEvents: .TouchUpInside)
        shareBtn.customView = button
        self.navigationItem.rightBarButtonItems = [shareBtn]
        
        
    }
    func SettingtUpBarButtonItems()
    {
        let shareButton = UIButton()
        shareButton.frame = CGRectMake(0, 0, 44, 44)
        shareButton.contentEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, -20)
        shareButton.setImage(UIImage(named:"ShareHeaderIconiPhone.png"), forState:.Normal)
        shareButton.addTarget(self, action: Selector("shareBtnAction"), forControlEvents: .TouchUpInside)
        let share_Btn = UIBarButtonItem()
        share_Btn.customView = shareButton
        
        let keyboardHideButton = UIButton()
        keyboardHideButton.frame = CGRectMake(0, 0, 44, 44)
        keyboardHideButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25)
        keyboardHideButton.setImage(UIImage(named:"KeyboardHeaderIconiPhone.png"), forState:.Normal)
        keyboardHideButton.addTarget(self, action: Selector("keyApperBtnAction"), forControlEvents: .TouchUpInside)
        let keyApper_Btn = UIBarButtonItem()
        keyApper_Btn.customView = keyboardHideButton
        //actionButtonItems = [keyApper_Btn,shareButton]as NSArray
        self.navigationItem.rightBarButtonItems = [keyApper_Btn,share_Btn]
        //self.navigationItem.setRightBarButtonItems(actionButtonItems! as? [UIBarButtonItem], animated: true)
        
    }
    // Mark :- Delete Note Temp
    
    @IBAction func actionBtnDelete(sender: AnyObject) {
    
        print("Note ID : \(strNoteId)")
        CNDataBaseHelper.JADeleteTempWithNoteID(strNoteId, userID: "1", isDelete: "1")
    
        print("visibleIndexPath : \(visibleIndexPath.row)")
        
        self.removeNoteFormArray(visibleIndexPath.row)
        //self.collectionsDetils.reloadData()
    }
   
    // Mark : - Remove the items in Array 
    
    func removeNoteFormArray(indexPath :  NSInteger)
    {
        print("page Index \(indexPath)")
        
        arrNoteItems.removeObjectAtIndex(indexPath)
    
        self.noteDisplayWithIndexPath(indexPath)
        
        
        
        /// 
        
        //        arrNoteItems.removeObjectAtIndex(indexPath)
        //
        //     if arrNoteItems.count > 0
        //    {
        //
        //        if indexPath > arrNoteItems.count-1
        //        {
        //            var temp = indexPath
        //            temp -= 1
        //         visibleIndexPath = NSIndexPath(forRow: temp ,  inSection: 0 )
        //
        //            self.noteDisplayWithIndexPath(temp)
        //        }
        //        else
        //        {
        //
        //        }
        //        
        //        }
        //     else
        //     {
        //        self.navigationController?.popViewControllerAnimated(true)
        //        }
        
    }
    
    // Mark :- Display Select Note Details With Index path.
    
    func noteDisplayWithIndexPath(indexPath : NSInteger)
    {
        if arrNoteItems.count > 0
        {
        print("arrNoteItems count :\(arrNoteItems.count)")
        _objMaster = arrNoteItems .objectAtIndex(indexPath) as! MasterNote
        print( " note Name \(_objMaster .noteName)")
        collectionsDetils.reloadData()
        }
        else
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: -  Collections View Delegate and datasourse
    
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrNoteItems != nil
        {
        return arrNoteItems.count
        }
        else
        {
        return 0
        }
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "CNNoteDescriptionsCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CNNoteDescriptionsCell
       // cell.txtNoteTitle.text = arrAllNoteList[indexPath.row]  as? String
        cell.txtNoteTitle.text = _objMaster.noteName
        cell.txtArea.text     = _objMaster.fileData
        strTextField =    cell.txtNoteTitle.text
        strTextView  =    cell.txtArea.text
        strNoteId   = _objMaster.noteCreateID
        self.labCount(strTextView)
        cell.btnCross.tag = indexPath.row
        cell.btnCross.addTarget(self, action: #selector(CNNoteDescriptionsViewController.actionCross(_:)), forControlEvents: .TouchUpInside)
        return cell

    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionsDetils.contentOffset
        visibleRect.size = collectionsDetils.bounds.size
        
        let visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMaxY(visibleRect))
        
        visibleIndexPath   = collectionsDetils.indexPathForItemAtPoint(visiblePoint)! as NSIndexPath
        self.noteDisplayWithIndexPath(visibleIndexPath.row)
        
        
    }
    
    
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
    
        return 0.0
    }
  
    
    
    // MARK : - User define functions
    
    func noteSave()  // this function update a save note
    {
        
        if istextEdit == true
        {
            CNDataBaseHelper.JAupdateNoteWithNoteID(strNoteId, userID: "1", noteTitle:strTextField , noteData: strTextView, updateTime: date.gettimestampStringFroLocalTime(), isSynchoronization: "0")
        }
       
        self.navigationController?.popViewControllerAnimated(true)
        
        
        
    }
    func actionCross(sender:UIButton)
    {
        let reuseIdentifier = "CNNoteDescriptionsCell"
     
        let pointInTable: CGPoint =         sender.convertPoint(sender.bounds.origin, toView: collectionsDetils)
        
        let cellIndexPath = collectionsDetils.indexPathForItemAtPoint(pointInTable)
        
        print(cellIndexPath)
        //let Indexpath:NSIndexPath = sender.tag
        
        //let cell = UICollectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: sender.tag) as! CNNoteDescriptionsViewController
        
       let cell = collectionsDetils.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: cellIndexPath!) as!CNNoteDescriptionsCell
        
        cell.txtNoteTitle.text = ""
        
    
    }
   
    func CNRequestAuthenticateUserWithEmail(email: String, password: String, success: (responseDict: AnyObject) -> Void, failure: (operation: CNNoteDescriptionsViewController, error: NSError) -> Void) {
    }
    
// Mark : -  Text Field Delegte
    
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
    
        strTextField = textField.text
        if ((textField.text) != nil)
        {
            strTextField = strTextField!.stringByReplacingCharactersInRange(range, withString: string)
            if strTextField?.length > 0
            {
                
            
            }
            else
            {
    
            }

        }
        istextEdit = true
        return true
    }
    

    // Mark : - Text Area delegate
    func textView(textView: UITextView,shouldChangeTextInRange range: NSRange,replacementText text: String) -> Bool
    {
        strTextView = textView.text
        
        strTextView = strTextView?.stringByReplacingCharactersInRange(range, withString: text)
        print(strTextView!)
        if self.trim(strTextView!).length == 0
        {
            lblCount.text = "0" + " Words"
            
        }
        else
        {
            var words : Int =  0;
            
                let scanner = NSScanner(string: strTextView as String)
                let whiteSpace = (NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            while scanner.scanUpToCharactersFromSet(whiteSpace, intoString: nil)
            {
               
                  words += 1
                
                if words > 1 {
                    lblCount.text = "\(Int(words)) Words"
                }
                else {
                    lblCount.text = "\(Int(words)) Word"
                }
            }
          
            
        }
        istextEdit = true
        return true
    }
    
    
    func labCount(strText : NSString!)
    {
        if self.trim(strText!).length == 0
        {
            lblCount.text = "0" + " Words"
            
        }
        else
        {
            var words : Int =  0;
            
            

            
            let scanner = NSScanner(string: strText as String)
            let whiteSpace = (NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            while !scanner.atEnd
            {
                scanner.scanUpToCharactersFromSet(whiteSpace, intoString: nil)
             
                words += 1
            }
                if words > 1 {
                    lblCount.text = "\(Int(words)) Words"
                }
                else {
                    lblCount.text = "\(Int(words)) Word"
                }


            
            
        
        }
        
    }
    
    
}
