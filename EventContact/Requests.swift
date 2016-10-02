//
//  Requests.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

protocol JSONable {
    func toJSONData() -> Data?
}

struct LoginRequest: JSONable {
    var email: String
    var password: String
    
    func toJSONData() -> Data? {
        var dict = [String:Any]()
        
        dict["email"] = email
        dict["password"] = password
        
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        let dataJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
        print(dataJSON)
        
        return data
    }
}

struct RegisterRequest: JSONable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    
    func toJSONData() -> Data? {
        
        var dict = [String:Any]()
        
        dict["firstName"] = firstName
        dict["lastName"] = lastName
        dict["email"] = email
        dict["password"] = password
        
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        return data
        
    }
}

struct EventInfoRequest: JSONable {
    var eventId: Int
    
    func toJSONData() -> Data? {
        
        var dict = [String:Any]()
        
        dict["eventId"] = eventId
        
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        return data
        
    }
}

struct NewEvent {
    var title: String
    var address: String
    var description: String
    var date: String
    var time: String
    
    func getDictionary() -> [String:Any] {
        let dict = ["title" :title,
                    "address" : address,
                    "description" : description,
                    "date" : date,
                    "time": time]
        
        return dict
    }
}

struct AddEventRequest: JSONable {
    var adminUser: Int
    var event: NewEvent
    
    func toJSONData() -> Data? {
        
        let dict: [String:Any] = ["adminUser" : adminUser,
                                  "event" : event.getDictionary()]
        
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        return data
        
    }
}
