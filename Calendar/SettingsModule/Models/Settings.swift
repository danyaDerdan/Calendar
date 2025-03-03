import Foundation

struct Settings {
    var name: String
    var themeColor: Color
    var birthday: Date
    var notificationSound: Sound
    var avatar: Avatar
    
    enum Color {
        case blue
        case green
        case pink
        case purple
    }
    
    enum Sound {
        case defaultSound
        case critical
    }
    
    enum Avatar {
        case Panda
        case Cat
        case Dog
    }
}
