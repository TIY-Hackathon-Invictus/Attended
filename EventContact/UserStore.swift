//
//  File.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

class UserStore {
    var user: User? = nil
    var otherUsers = [User]()
    fileprivate let session = URLSession.shared
}

extension UserStore {
    
    func loginUser(requestBody: LoginRequest, completion: @escaping (EventContactAuthResult) -> (Void)) {
        
        var fetchUserRequest = URLRequest(url: EventContactAPI.urlFor(endpoint: .Login))
        fetchUserRequest.httpMethod = "POST"
        EventContactAPI.addJSONHeadersTo(request: &fetchUserRequest)
        
        fetchUserRequest.httpBody = requestBody.toJSONData()
        
        let fetchUserTask = session.dataTask(with: fetchUserRequest) {
            (data, response, _) in
            
            var result: EventContactAuthResult
            
            guard let unwrappedData = data,
                let json = EventContactAPI.dataToJSONData(unwrappedData) as? [String:Any] else {
                    result = EventContactAuthResult.Failure(error: EventContactError.InvalidJSON, message: "Server error")
                    return
            }
            
            if let errorMessage = json["message"] as? String {
                result = .Failure(error: EventContactError.UserDoesNotExist, message: errorMessage)
                return
            }
            
            result = EventContactAPI.currentUserFrom(json: json)
            
            switch result {
            case let .Success(user):
                self.user = user
            case .Failure(_):
                return
            }
            
            completion(result)
        }
        
        fetchUserTask.resume()
        
    }
    
    func registerUser(requestBody: RegisterRequest, completion: @escaping (EventContactAuthResult) -> (Void)) {
        
        var registerUserRequest = URLRequest(url: EventContactAPI.urlFor(endpoint: .Register))
        registerUserRequest.httpMethod = "POST"
        EventContactAPI.addJSONHeadersTo(request: &registerUserRequest)
        
        registerUserRequest.httpBody = requestBody.toJSONData()
        
        let registerUserTask = session.dataTask(with: registerUserRequest) {
            (data, response, error) in
            
            var result: EventContactAuthResult
            
            guard let unwrappedData = data,
                let json = EventContactAPI.dataToJSONData(unwrappedData) as? [String:Any] else {
                    result = EventContactAuthResult.Failure(error: EventContactError.InvalidJSON, message: "Server error")
                    return
            }
            
            if let errorMessage = json["message"] as? String {
                result = .Failure(error: EventContactError.CouldNotCreateUser, message: errorMessage)
                return
            }
            
            result = EventContactAPI.currentUserFrom(json: json)
            
            switch result {
            case let .Success(user):
                self.user = user
            case .Failure(_):
                return
            }
            
            completion(result)
        }
        
        registerUserTask.resume()
        
    }

    
}

extension UserStore {
    
}
