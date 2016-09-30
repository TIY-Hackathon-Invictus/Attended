//
//  JSONToEntity.swift
//  EventContact
//
//  Created by Princess Sampson on 9/30/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

import Foundation

import Foundation
import CoreData

func dictionary<Entity>(_ dictionary: [String : Any], toEntity entityHandler: ([String : Any]) -> Entity?) -> Entity? {
    
    return entityHandler(dictionary)
}
