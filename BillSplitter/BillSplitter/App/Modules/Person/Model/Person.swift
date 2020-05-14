//
//  Person.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object, Codable {
    
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var email: String?
    @objc dynamic var phone: String?
    @objc dynamic var imageData: Data?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func update(name: String, email: String?, phone: String?, imageData: Data?) {
        self.name = name
        self.email = email
        self.phone = phone
        self.imageData = imageData
    }
    
}
