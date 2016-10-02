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
            (data, response, error) in
            
            var result: EventContactAuthResult
            
            guard let unwrappedData = data else {
                result = EventContactAuthResult.Failure(EventContactError.InvalidUsernameOrPassword)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode != 200 else {
                result = EventContactAuthResult.Failure(EventContactError.UserDoesNotExist)
                return
                
            }
            
            result = EventContactAPI.currentUserFrom(data: unwrappedData)
            
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
    
}

extension UserStore {
    
}
