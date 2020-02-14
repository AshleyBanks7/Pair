//
//  Person.swift
//  Pair
//
//  Created by Maxwell Poffenbarger on 2/14/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import Foundation

class Person: Codable {
    
    var name: String
    var timestamp: Date
    
    init(name: String, timestamp: Date = Date()) {
        self.name = name
        self.timestamp = timestamp
    }
}//End of class

extension Person: Equatable {
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name && lhs.timestamp == rhs.timestamp
    }
}//End of extension
