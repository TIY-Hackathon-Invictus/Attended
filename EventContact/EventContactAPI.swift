//
//  EventContactAPI.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

struct EventContactAPIConfig {
    let baseURL = "http://invictus-event-contact.herokuapp.com"
    
}

enum EventContactEndpoint: String {
    case Login = "/login"
    case Register = "/register"
    case Events = "/events"
}

enum EventContactAuthResult {
    case Success(User)
    case Failure(error: Error, message: String)
}

enum EventContactUsersResult {
    case Success([User])
    case Failure(Error)
}

enum EventContactEventsResult {
    case Success([Event])
    case Failure(error: Error, message: String)
}

enum EventContactError: Error {
    case InvalidJSON
    case UserDoesNotExist
    case CouldNotCreateUser
    case CouldNotFetchEvents
}

struct EventContactAPI {
    fileprivate static let config = EventContactAPIConfig()
}

extension EventContactAPI {
    static func currentUserFrom(json: [String:Any]) -> EventContactAuthResult {
        
        guard let user = userFrom(dictionary: json) else {
            return .Failure(error: EventContactError.InvalidJSON, message: "Internal server error")
        }
        
        return .Success(user)
    }
}

extension EventContactAPI {
    
    static func urlFor(endpoint: EventContactEndpoint) -> URL {
        
        let urlString = config.baseURL.appending(endpoint.rawValue)
        let url = URL(string: urlString)!
        
        return url
    }
    
    static func addJSONHeadersTo(request: inout URLRequest) {
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    static func dataToJSONData(_ data: Data) -> Any? {
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return nil
        }
        
        return json
    }
    
    fileprivate static func userFrom(dictionary: [String:Any]) -> User? {
        return User(dict: dictionary)
    }
    
    static func eventsFrom(json: [[String:Any]]) -> EventContactEventsResult {
        let events = json.flatMap(Event.init)
        
        return .Success(events)
    }
}
