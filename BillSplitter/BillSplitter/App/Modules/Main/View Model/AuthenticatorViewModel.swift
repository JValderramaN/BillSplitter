//
//  AuthenticatorViewModel.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import Foundation
import LocalAuthentication

struct AuthenticatorViewModel {
    
    func authenticate(with policy: LAPolicy = .deviceOwnerAuthentication,
                      reason: String = "Plesase, authenticate yourself",
                      callback: @escaping (Bool, Error?) -> Void) {
        
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(policy, error: &error) else {
            callback(false, error)
            return
        }
        
        context.evaluatePolicy(policy, localizedReason: reason, reply: callback)
    }
    
}
