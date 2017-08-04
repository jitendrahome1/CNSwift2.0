//
//  CNAllNotsListViewController.swift
//  ClearNoteSwift
//
//  Created by Jitendra Agarwal on 09/06/16.
//  Copyright © 2016 Jitendra Agarwal. All rights reserved.
//

import UIKit

class CNAllNotsListViewController: CNBaseViewController {
    
    var myArray:NSArray?
    var arrNoteList:NSMutableArray?
    let date = NSDate()
    
    @IBOutlet weak var tblNoteList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrNoteList = NSMutableArray()
        self.setupUI()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = "All Notes"
        
        arrNoteList?.removeAllObjects()
        myArray = CNDataBaseHelper.JAfetchNotsWithUserID("1" , isDelete: "0") as NSArray
        if myArray!.count > 0
        {
            arrNoteList?.addObjectsFromArray(myArray! as [AnyObject])
        }
        tblNoteList.reloadData()
        
    }
    
    // MARK: - Table view Delegate and datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrNoteList?.count > 0
        {
            return (arrNoteList?.count)!
        }
        else
        {
            return 0
        }
        
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CNAllNotsListCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier , forIndexPath: indexPath) as! CNAllNotsListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //        let dictNoteList:NSDictionary? = arrNoteList?[indexPath.row] as? NSDictionary
        //        print(dictNoteList!)
        //        cell.lblTitleName.text = dictNoteList?.valueForKey("noteName") as? String
        //        cell.lblDateTime.text = (date.datefetch((cnDefult.objectForKey(KDefultTimeStamp) as? NSString)!) as String) + " " + (date.TimeAMPMWithData((cnDefult.objectForKey(KDefultTimeStamp) as? NSString)!) as String)
        
        let objMaster = arrNoteList!.objectAtIndex(indexPath.row) as! MasterNote
        cell.lblTitleName.text = objMaster.noteName! as String
        cell.lblDateTime.text = ((date.datefetch(objMaster.noteCreateDate!)) as String) + " " + ((date.TimeAMPMWithData((objMaster.noteCreateDate!)) ) as String)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cnNoteDescriptons = self.storyboard?.instantiateViewControllerWithIdentifier("CNNoteDescriptionsViewController")as! CNNoteDescriptionsViewController
        cnNoteDescriptons.arrAllNoteList = arrNoteList
        cnNoteDescriptons.pageIndex = indexPath.row as NSInteger
        
        self.navigationController?.pushViewController(cnNoteDescriptons, animated: true)
    }
    
    // MARK:- User Define Functions.
    func setupUI()
    {
        navigationController?.navigationBarHidden = false
        navigationController!.navigationBar.translucent = false;
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes = ([NSFontAttributeName: fontWithSize(16),NSForegroundColorAttributeName: kDefaulColor])
        let newNoteBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(CNAllNotsListViewController.actionCreateNewNote))
        
        // crete a sync button
        var syncImage = UIImageView()
        let image : UIImage = UIImage(named:"SynchronizationHeaderIconiPhone.png")!
        syncImage = UIImageView(image: image)
        let synchronizationBtn = UIButton()
        synchronizationBtn.frame = CGRectMake(0, 0, 44, 44)
        synchronizationBtn.setImage(syncImage.image, forState:.Normal)
        synchronizationBtn.bounds = syncImage.bounds
        //synchronizationBtn.addSubview(syncImage)
        synchronizationBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25)
        synchronizationBtn.addTarget(self, action: #selector(CNAllNotsListViewController.actionSync), forControlEvents:.TouchUpInside)
        let syncBarBtnItems = UIBarButtonItem()
        syncBarBtnItems.customView = synchronizationBtn
        self.navigationItem.rightBarButtonItems = [newNoteBtn, syncBarBtnItems]
        // crete a setting button
        var btnSetting = UIBarButtonItem()
        btnSetting = UIBarButtonItem(image: UIImage(named: "SettingsHeaderIconiPhone.png"), style:UIBarButtonItemStyle.Plain, target: self, action: #selector(CNAllNotsListViewController.actionSetting))
        self.navigationItem.leftBarButtonItem = btnSetting
        
        
    }
    
    func actionCreateNewNote()
    {
        let creteNewNoteVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNCreateNoteViewController") as! CNCreateNoteViewController
        navigationController?.pushViewController(creteNewNoteVC, animated: true)
        
    }
    func actionSync()
    {
        // action for sync
    }
    func actionSetting()
    {
        let settingVC = self.storyboard?.instantiateViewControllerWithIdentifier("CNSettingViewController") as! CNSettingViewController
        
        
        self.navigationController?.pushViewController(settingVC, animated: true)
        
    }
    func sortBYAlphabet(unsortArry:[String]?)->NSArray
    {
        let arrValue = unsortArry?.sort()
        return arrValue!
        
    }
    
}