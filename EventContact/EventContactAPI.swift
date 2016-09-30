//
//  EventContactAPI.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

struct EventContactAPIConfig {
    let baseURL = ""

}

enum EventContactEndpoints: String {
    case Login = "/login"
    case Register = "/register"
}

enum EventContactAuthenticateUser: Error {
    case Success(User)
    case Failure(Error)
}

struct EventContactAPI {
    let Config = EventContactAPIConfig()
}

extension EventContactAPI {
    
    static func userFrom(json: [String : Any]) -> User? {
        return nil
    }

}
