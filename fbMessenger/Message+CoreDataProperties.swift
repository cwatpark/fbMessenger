//
//  Message+CoreDataProperties.swift
//  fbMessenger
//
//  Created by Ice on 11/2/2562 BE.
//  Copyright © 2562 Ice. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: NSDate?

}
