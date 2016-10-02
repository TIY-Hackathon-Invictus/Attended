//
//  User.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

class User {
    var isAdmin: Bool
    var email: String
    var firstName: String
    var lastName: String
    var userID: Int
    
    init?(dict: [String:Any]) {
        
        guard let adminJSON = dict["admin"] as? Bool,
            let emailJSON = dict["email"] as? String,
            let firstNameJSON = dict["firstName"] as? String,
            let lastNameJSON = dict["lastName"] as? String,
            let idJSON = dict["userId"] as? Int else {
                return nil
        }
        
        isAdmin = adminJSON
        email = emailJSON
        firstName = firstNameJSON
        lastName = lastNameJSON
        userID = idJSON
        
        
    }
}
