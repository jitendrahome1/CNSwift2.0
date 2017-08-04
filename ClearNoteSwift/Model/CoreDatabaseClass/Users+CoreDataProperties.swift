//
//  Users+CoreDataProperties.swift
//  ClearNoteSwift
//
//  Created by Jitendra on 7/19/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Users {

    @NSManaged var email: String?
    @NSManaged var userID: String?
    @NSManaged var userName: String?
    @NSManaged var userPassword: String?

}
