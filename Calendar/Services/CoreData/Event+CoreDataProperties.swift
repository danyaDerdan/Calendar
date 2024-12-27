//
//  Event+CoreDataProperties.swift
//  Calendar
//
//  Created by Данил Толстиков on 18.12.2024.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var notification: Bool
    @NSManaged public var startDate: Date?

}

extension Event : Identifiable {

}
