//
//  EventsandnotesStore+CoreDataProperties.swift
//  Eventsandnotes
//
//  Created by Ganesh on 8/10/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension EventsandnotesStore {

    @NSManaged var sDescription: String?
    @NSManaged var sImage: NSData?
    @NSManaged var sName: String?
    @NSManaged var sTitle: String?
    @NSManaged var sNote: String?
   
}
