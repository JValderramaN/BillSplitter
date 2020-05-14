//
//  BillViewModel.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import Foundation
import RealmSwift

struct BillViewModel {
    
    func bills() throws -> Results<Bill> {
        let realm = try Realm()
        return realm.objects(Bill.self)
    }
    
    func delete(_ bill: Bill) throws {
        let realm = try Realm()
        try realm.write() {
            realm.delete(bill)
        }
    }
    
    func save(_ bill: Bill) throws {
        let realm = try Realm()
        try realm.write() {
            realm.add(bill, update: .all)
        }
    }

    func updateAndSave(_ bill: Bill, name: String, total: Float) throws {
        if let realm = bill.realm {
            try realm.write() {
                bill.update(name: name, total: total)
            }
        } else {
            bill.update(name: name, total: total)
        }
        
        try save(bill)
    }

}
