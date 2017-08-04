//
//  MasterNote+CoreDataProperties.swift
//  
//
//  Created by Jitendra on 7/20/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MasterNote {

    @NSManaged var fileData: String?
    @NSManaged var isdeleted: NSNumber?
    @NSManaged var isSynchoronization: NSNumber?
    @NSManaged var noteCreateDate: String?
    @NSManaged var noteCreateID: String?
    @NSManaged var noteName: String?
    @NSManaged var tempUserId: String?
    @NSManaged var timestamp: String?
    @NSManaged var userID: String?

}
