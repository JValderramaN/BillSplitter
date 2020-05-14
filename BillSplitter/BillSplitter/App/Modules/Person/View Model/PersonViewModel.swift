//
//  PersonViewModel.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import Foundation
import RealmSwift

struct PersonViewModel {
    
    func persons() throws -> Results<Person> {
        let realm = try Realm()
        return realm.objects(Person.self)
    }
    
    func delete(_ person: Person) throws {
        let realm = try Realm()
        try realm.write() {
            realm.delete(person)
        }
    }
    
    func save(_ person: Person) throws {
        let realm = try Realm()
        try realm.write() {
            realm.add(person, update: .all)
        }
    }
    
    func update(_ person: Person, imageData: Data?) throws {
        if let realm = person.realm {
            try realm.write() {
                person.imageData = imageData
            }
        } else {
            person.imageData = imageData
        }
    }
    
    func updateAndSave(_ person: Person, name: String, email: String?, phone: String?, imageData: Data?) throws {
        if let realm = person.realm {
            try realm.write() {
                person.update(name: name, email: email, phone: phone, imageData: imageData)
            }
        } else {
            person.update(name: name, email: email, phone: phone, imageData: imageData)
        }
        
        try save(person)
    }

}
