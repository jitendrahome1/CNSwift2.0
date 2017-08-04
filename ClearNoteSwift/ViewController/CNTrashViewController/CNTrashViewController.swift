//
//  CNTrashViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 10/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNTrashViewController: CNBaseViewController {

    @IBOutlet weak var tblTrash: UITableView!
    //var numbers = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"]
  
    var numbers:[AnyObject]?
    var arrNoteList : NSMutableArray!
    var btnEmpty = UIBarButtonItem()
    var strNoteID : NSString!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        numbers = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"]
        arrNoteList = NSMutableArray()
        self.tblTrash.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
           navigationItem.title = "Trash"
        navigationItem.hidesBackButton = true
        self.fetchNoteList()
       
    }
    func setupUI()
    {
        navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.translucent = false;
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes = ([NSFontAttributeName: fontWithSize(16),NSForegroundColorAttributeName: kDefaulColor])
         btnEmpty = UIBarButtonItem(title: "Empty", style: .Plain, target: self, action: #selector(CNTrashViewController.actionEmpty))
        self.navigationItem.rightBarButtonItems = [btnEmpty]
    
        
        let backBtn = UIBarButtonItem(image: UIImage(named:"BackHeaderIconiPhone.png"), style:UIBarButtonItemStyle.Plain, target: self, action: #selector(CNTrashViewController.actionBack))
        navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: fontWithSize(16),NSForegroundColorAttributeName: kDefaulColor], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = backBtn
        
    }
    
    // Mark : - Fetch Note List
    func fetchNoteList()
    {
        arrNoteList.removeAllObjects()
        let arrTemp = CNDataBaseHelper.JAfetchNotsWithUserID("1", isDelete: "1")
        if arrTemp.count > 0
        {   btnEmpty.enabled = true
            arrNoteList.addObjectsFromArray(arrTemp as [AnyObject])
              tblTrash.reloadData();
            
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil
          tblTrash.reloadData();
        }
        
    }
    
    // MARK: - Table view Delegate and datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // print("total count  \(numbers.count)")
        if let arrData = arrNoteList
        {
              return arrData.count
        }
        else
        {
        return 0
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 66.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CNTrashCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier , forIndexPath: indexPath) as! CNTrashCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let _objMaster = arrNoteList.objectAtIndex(indexPath.row) as! MasterNote
         cell.lblNoteName.text = _objMaster.noteName! as String
        
        //cell.lblNoteName.text = ar?[indexPath.row] as? String
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
  
       tblTrash.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    func tableView(tableView: UITableView!, editActionsForRowAtIndexPath indexPath: NSIndexPath!) -> [AnyObject]! {
        
        let trashAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "        ", handler: {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            print("Triggered trashAction action")
            //  self.numbers?.removeAtIndex(indexPath.row)
               let _obj = self.arrNoteList.objectAtIndex(indexPath.row) as! MasterNote
            CNDataBaseHelper.JADeletePermanentlyWithNoteID(_obj.noteCreateID, userID: "1")
            
            //self.tblTrash.reloadData()
            self.fetchNoteList()
           // return
        })
        
        trashAction.backgroundColor = UIColor(patternImage: UIImage(named: "DeleteiPhone")!)
        
        let restoreAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "        ", handler: {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            let _obj = self.arrNoteList.objectAtIndex(indexPath.row) as! MasterNote
            
            print("Triggered restoreAction action ")
            CNDataBaseHelper.JARestoreWithNoteID(_obj.noteCreateID, userID: "1", isDelete: "0")
           self.fetchNoteList()
            return
        })
           restoreAction.backgroundColor = UIColor(patternImage: UIImage(named: "RestoreiPhone")!)
        return [restoreAction, trashAction]
    }

    
    // MARK:- User Define functions
    func actionBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
        // back action
        
    }
    func actionEmpty()
    {
        for i in 0 ..< arrNoteList.count
        {
            let _obj = self.arrNoteList.objectAtIndex(i) as! MasterNote
             CNDataBaseHelper.JADeletePermanentlyWithNoteID(_obj.noteCreateID, userID: "1")
      
        }
              self.fetchNoteList()
//
    }
    
    func loadTableView()
    {
        print("count  \(numbers!.count)")
        if numbers?.count <= 0
        {
          self.navigationItem.rightBarButtonItems = nil
            self.tblTrash.reloadData()
        }
        else
        {
            self.tblTrash.reloadData()
        }

        
    }
}
