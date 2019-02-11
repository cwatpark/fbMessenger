//
//  Friend+CoreDataProperties.swift
//  fbMessenger
//
//  Created by Ice on 11/2/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImageName: String?

}
