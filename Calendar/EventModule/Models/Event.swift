import Foundation

enum EventSettings {
    case valid
    case invalid
    
    struct Event {
        var name: String
        var description: String
        var start: Date
        var end: Date
        var notification: Bool
    }
}
