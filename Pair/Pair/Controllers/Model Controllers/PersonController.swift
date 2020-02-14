//
//  PersonController.swift
//  Pair
//
//  Created by Maxwell Poffenbarger on 2/14/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import Foundation

class PersonController {
    
    //MARK: - Properties
    static let sharedInstance = PersonController()
    var persons: [Person] = []
    
    //MARK: - CRUD Functions
    func createPerson(name: String) {
        let person = Person(name: name)
        persons.append(person)
        
        saveToPersistentStore()
    }
    
    func deletePerson(person: Person) {
        guard let index = persons.firstIndex(of: person) else {return}
        persons.remove(at: index)
        
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    func createFileForPersistence() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Person.json")
        return fileURL
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonPersons = try jsonEncoder.encode(persons)
            try jsonPersons.write(to: createFileForPersistence())
        } catch let encodingError {
            print("There was an error saving the data! \(encodingError.localizedDescription)")
        }
    }
    
    func loadFromPersistantStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: createFileForPersistence())
            let decodedPersonsArray = try jsonDecoder.decode([Person].self, from: jsonData)
            persons = decodedPersonsArray
        } catch let decodingError {
            print("There was an error loading the data! \(decodingError.localizedDescription)")
        }
    }
}//End of class
