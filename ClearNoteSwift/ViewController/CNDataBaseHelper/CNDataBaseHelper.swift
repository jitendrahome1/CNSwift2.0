//
//  CNDataBaseHelper.swift
//  ClearNoteSwift
//
//  Created by Jitendra on 7/19/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//

import UIKit
import CoreData
class CNDataBaseHelper: NSObject {

    // Mark :-  save user Deatils  
    
    class func JAsaveRecord( userID:NSString! , userName:NSString!, email:NSString!, password:NSString!)->Void
    {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let userDetails : Users?      =  NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext:managedContext) as? Users
//        
//        if((userDetails) != nil)
//        {
//            
//        }
        
        if let objUser = userDetails
        {
            objUser.userID = userID as String
            objUser.email = email as String
             objUser.userName = userName as String
             objUser.userPassword = password as String
         
            do {
                try objUser.managedObjectContext?.save()
                
            } catch {
                let saveError = error as NSError
                print(saveError)
            }

        }
   
    }
    
    // Mark :- Check Email id alredy Exist.
    class func JAcheckEmailExist(email:NSString!)->Bool
    {
        var result : Bool!
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
          let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext:managedContext)
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email == %@", email!)
        fetchRequest.predicate = predicate
        do{
         let arrResult:NSArray =  try managedContext.executeFetchRequest(fetchRequest)
            if arrResult.count > 0
            {
                result =  true
                
            }
            else{
                result =  false
                
            }
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return result;
    }
    // Mark :- User authenticate
    
    class func JAauthenticateUsers(email:NSString! , password:NSString!)->NSArray!
    {
        var result = [];
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "email == %@ AND userPassword == %@", email! , password!)
        fetchRequest.predicate = predicate
        do
        {
            try result = managedContext.executeFetchRequest(fetchRequest)
            
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        return result;
        
    }
    
    // Mark : - Insert New Note In Master Table
    
    class func JAInsertNewNoteWithUserID(userID : NSString! , noteID : NSString! , noteName : NSString! , noteData :  NSString! ,  noteCreatedDate : NSString! ,  isDelete : NSString , isSynchoronization : NSString! , tempUserID :  NSString! )->MasterNote
    {
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let master : MasterNote?      =  NSEntityDescription.insertNewObjectForEntityForName("MasterNote", inManagedObjectContext:managedContext) as? MasterNote

        
        if let objMaster = master
        {
            objMaster.userID               = userID  as String
            objMaster.noteCreateID         = noteID  as String
            objMaster.fileData             = noteData  as String
            objMaster.noteCreateDate       = noteCreatedDate  as String
            objMaster.isdeleted            = NSNumber.init(int: isDelete.intValue)
            objMaster.isSynchoronization   = NSNumber.init(int: isSynchoronization.intValue)
            objMaster.tempUserId           = tempUserID  as String
            objMaster.noteName             = noteName as String
            objMaster.timestamp            = noteCreatedDate  as String
            do {
                try objMaster.managedObjectContext?.save()
                
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        }
        
        return master!
        
    }
    // Mark : - Fetch Notes  Records..
    
    class func JAfetchNotsWithUserID(userID :  NSString! , isDelete : NSString!)->NSArray!
    {
        var result : NSArray!
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("MasterNote", inManagedObjectContext:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "userID == %@ AND isdeleted == %@", userID! , isDelete!)
        fetchRequest.predicate = predicate
        do
        {
            try result = managedContext.executeFetchRequest(fetchRequest)
            
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        return result
    }
     // Mark : - // Update note
    
    class func JAupdateNoteWithNoteID(noteID : NSString! ,  userID : NSString! ,  noteTitle : NSString! , noteData : NSString! , updateTime : NSString! , isSynchoronization : NSString!)
    {
          let arrResult : NSArray?
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("MasterNote", inManagedObjectContext:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "userID == %@ AND noteCreateID == %@", userID! , noteID!)
         fetchRequest.predicate = predicate
        do {
            
            arrResult =   try managedContext.executeFetchRequest(fetchRequest)
            if let arrData = arrResult
            {
                
                let objMasterNote  = arrData[0]  as! MasterNote
                
                objMasterNote.noteName = noteTitle as String
                objMasterNote.fileData = noteData as String
                objMasterNote.fileData = noteData as String
                objMasterNote.noteCreateDate = updateTime as String
                try  appDel.managedObjectContext.save()
            }
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }

    }
    
    // Mark : - delete  Temporary note with note id
    class func JADeleteTempWithNoteID(noteID : NSString! ,  userID : NSString! , isDelete :  NSString!)
    {
        let arrResult : NSArray?
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("MasterNote", inManagedObjectContext:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "userID == %@ AND noteCreateID == %@", userID! , noteID!)
        fetchRequest.predicate = predicate
        
        do {
            
            arrResult =   try managedContext.executeFetchRequest(fetchRequest)
            if let arrData = arrResult
            {
                
                let objMasterNote  = arrData[0]  as! MasterNote
                
                objMasterNote.isdeleted = NSNumber.init(int: isDelete.intValue)
             
                try  appDel.managedObjectContext.save()
            }
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    // Mark :- Delte Permanently Note
    
    class func JADeletePermanentlyWithNoteID(noteID : NSString! ,  userID : NSString!)
    {
        let arrResult : NSArray?
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("MasterNote", inManagedObjectContext:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "userID == %@ AND noteCreateID == %@", userID! , noteID!)
        fetchRequest.predicate = predicate
        do {
            
            arrResult =   try managedContext.executeFetchRequest(fetchRequest)
            
            if let arrData = arrResult
            {
                for result: AnyObject in arrData{
                    
                    appDel.managedObjectContext.deleteObject(result as! NSManagedObject)
                }
                try appDel.managedObjectContext.save()
                
            }
            
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }

        
    }
    
    // Mark : - // Restore Note
    
    class func JARestoreWithNoteID(noteID : NSString! ,  userID : NSString! , isDelete :  NSString!)
    {
        let arrResult : NSArray?
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext   =  appDel.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("MasterNote", inManagedObjectContext:managedContext)
        fetchRequest.entity = entityDescription
        let predicate = NSPredicate(format: "userID == %@ AND noteCreateID == %@", userID! , noteID!)
        fetchRequest.predicate = predicate
        
        do {
            
            arrResult =   try managedContext.executeFetchRequest(fetchRequest)
            if let arrData = arrResult
            {
                
                let objMasterNote  = arrData[0]  as! MasterNote
                
                objMasterNote.isdeleted = NSNumber.init(int: isDelete.intValue)
                
                try  appDel.managedObjectContext.save()
            }
        }
        catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }


}
