//
//  Event+CoreDataClass.swift
//  Calendar
//
//  Created by Данил Толстиков on 18.12.2024.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        self.init(entity: CoreDataManager().entityForName("Event"), insertInto: CoreDataManager().context)
    }
}
