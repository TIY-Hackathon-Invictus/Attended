//
//  EventContactAPI.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

struct EventContactAPIConfig {
    let baseURL = "http://event-contact-2016.herokuapp.com"
    
}

enum EventContactEndpoint: String {
    case Login = "/login"
    case Register = "/register"
}

enum EventContactAuthResult {
    case Success(User)
    case Failure(Error)
}

enum EventContactUsersResult {
    case Success([User])
    case Failure(Error)
}

enum EventContactError: Error {
    case InvalidUsernameOrPassword
    case InvalidJSON
    case UserDoesNotExist
}

struct EventContactAPI {
    fileprivate static let config = EventContactAPIConfig()
}

extension EventContactAPI {
    
    static func currentUserFrom(data: Data) -> EventContactAuthResult {
        
        guard let responseJSON = EventContactAPI.dataToJSONData(data) else {
                return .Failure(EventContactError.InvalidJSON)
        }
        
        let responseDictionary = responseJSON as? [String:Any]
        let user = userFrom(dict: responseDictionary!)
        
        print(user)
        
        return .Success(user!)
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
    
    static func dataToJSONData(_ data: Data?) -> Any? {
        
        var json: Any?
        let jsonData = (try? JSONSerialization.jsonObject(with: data!, options: []))
        json = jsonData
        
        return json
    }
    
    fileprivate static func userFrom(dict: [String:Any]) -> User? {
        
//        guard let user = dictionary(dict, toEntity: User.init) else {
//            return nil
//        }
        
        return User(dict: dict)
    }
}
