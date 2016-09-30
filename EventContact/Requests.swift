//
//  Requests.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

struct LoginRequest {
    var email: String
    var password: String

}

struct RegisterRequest {
    var email: String
    var firstName: String
    var lastName: String
    var password: String
}
