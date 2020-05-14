//
//  Bill.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import Foundation
import RealmSwift

class Bill: Object, Codable {
    
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var total: Float = 0.0
    let persons = List<Person>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func update(name: String, total: Float) {
        self.name = name
        self.total = total
    }
    
}
