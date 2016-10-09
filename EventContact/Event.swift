//
//  Event.swift
//  EventContact
//
//  Created by Princess Sampson on 10/2/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

class Event {
    var eventId: Int
    var title: String
    var address: String
    var description: String
    var date: String
    var time: String
    var admin: User
    
    init?(dict: [String:Any]) {
        
        guard let eventIdJSON = dict["eventId"] as? Int,
            let titleJSON = dict["title"] as? String,
            let addressJSON = dict["address"] as? String,
            let descriptionJSON = dict["description"] as? String,
            let dateJSON = dict["date"] as? String,
            let timeJSON = dict["time"] as? String,
            let userObj = dict["adminUser"] as? [String:Any] else {
                return nil
        }
        
        eventId = eventIdJSON
        title = titleJSON
        address = addressJSON
        description = descriptionJSON
        date = dateJSON
        time = timeJSON
        admin = User(dict: userObj)!
        
    }
}
