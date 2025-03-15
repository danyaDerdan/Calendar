import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func saveContext()
    func saveEvent(_ event: EventSettings.Event) //REDO EventModel to ViewModel
    func getEvents() -> [EventSettings.Event]
    func deleteEvent(event: EventSettings.Event)
}

final class CoreDataManager : CoreDataManagerProtocol{
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func entityForName(_ entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context) ?? NSEntityDescription()
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Calendar")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveEvent(_ event: EventSettings.Event) {
        let managedObject = Event(entity: entityForName("Event"), insertInto: context)
        managedObject.name = event.name
        managedObject.notification = event.notification
        managedObject.startDate = event.start
        managedObject.endDate = event.end
        saveContext()
    }
    
    func getEvents() -> [EventSettings.Event] {
        var array = [EventSettings.Event]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            let results = try context.fetch(fetchRequest) as? [Event]
            for result in results ?? [] {
                array.append(EventSettings.Event(name: result.name ?? "None",
                                                 description: "",
                                                 start: result.startDate ?? Date(),
                                                 end: result.endDate ?? Date(),
                                                 notification: result.notification))
            }
            
        } catch {
            print("Error")
        }
        return array
    }
    
    func deleteEvent(event: EventSettings.Event) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            let results = try context.fetch(fetchRequest) as? [Event]
            for result in results ?? [] {
                if result.name == event.name && result.startDate == event.start {
                    context.delete(result)
                    saveContext()
                    break
                }
            }
        } catch {
            print("Error")
        }
    }
}
