//
//  EventStore.swift
//  EventContact
//
//  Created by Princess Sampson on 10/2/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

class EventStore {
    var events = [Event]()
    fileprivate let session = URLSession.shared
}

extension EventStore {
    
    func fetchEvents(completion: @escaping (EventContactEventsResult) -> (Void)) {
        
        var fetchEventsRequest = URLRequest(url: EventContactAPI.urlFor(endpoint: .Events))
        fetchEventsRequest.httpMethod = "POST"
        EventContactAPI.addJSONHeadersTo(request: &fetchEventsRequest)
        
        let fetchEventsTask = session.dataTask(with: fetchEventsRequest) {
            (data, response, _) in
            
            var result: EventContactEventsResult
            
            guard let unwrappedData = data,
                let json = EventContactAPI.dataToJSONData(unwrappedData) as? [[String:Any]] else {
                    result = EventContactEventsResult.Failure(error: EventContactError.InvalidJSON, message: "Server error")
                    return
            }
            
            result = EventContactAPI.eventsFrom(json: json)
            
            switch result {
            case let .Success(events):
                self.events.append(contentsOf: events)
            case .Failure(_):
                return
            }
            
            completion(result)
        }
        
        fetchEventsTask.resume()
        
    }
    
    func fetchEventInfo(completion: @escaping (EventContactEventsResult) -> (Void)) {
        
        var fetchEventsRequest = URLRequest(url: EventContactAPI.urlFor(endpoint: .Events))
        fetchEventsRequest.httpMethod = "POST"
        EventContactAPI.addJSONHeadersTo(request: &fetchEventsRequest)
        
        let fetchEventsTask = session.dataTask(with: fetchEventsRequest) {
            (data, response, _) in
            
            var result: EventContactEventsResult
            
            guard let unwrappedData = data,
                let json = EventContactAPI.dataToJSONData(unwrappedData) as? [[String:Any]] else {
                    result = EventContactEventsResult.Failure(error: EventContactError.InvalidJSON, message: "Server error")
                    return
            }
            
            result = EventContactAPI.eventsFrom(json: json)
            
            switch result {
            case let .Success(events):
                self.events.append(contentsOf: events)
            case .Failure(_):
                return
            }
            
            completion(result)
        }
        
        fetchEventsTask.resume()
        
    }
    
}
