//
//  RequestTests.swift
//  EventContact
//
//  Created by Princess Sampson on 10/2/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import XCTest
@testable import EventContact

class RequestTests: XCTestCase {
    
    func testLoginRequest() {
        let request = LoginRequest(email: "p@samp.io", password: "p@ssword")
        let requestJSONData = request.toJSONData()
        
        let dict = ["email": "p@samp.io",
                           "password": "p@ssword"]
        let dictToJSONData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        XCTAssertEqual(dictToJSONData, requestJSONData)
    
    }
    
    func testRegisterRequest() {
        let request = RegisterRequest(firstName: "Nyota", lastName: "Uhura", email: "nyota@enterprise.io", password: "sp0ck")
        let requestJSONData = request.toJSONData()
        
        let dict = ["firstName": "Nyota",
                    "lastName": "Uhura"]
        let dictToJSONData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        XCTAssertEqual(dictToJSONData, requestJSONData)
        
    }
    
}
