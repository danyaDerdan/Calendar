enum DayViewState {
    case data(data: ViewData)
    case error
    
    struct ViewData {
        var events: [EventSettings.Event]
    }
}
