//
//  AuthenticatorViewController.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit

class AuthenticatorViewController: UIViewController {
    
    let viewModel = AuthenticatorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func authenticateButtonTapped(_ sender: Any) {
        viewModel.authenticate { (granted, error) in
            guard granted else { return }

            DispatchQueue.main.async { [weak self] in
                self?.performSegue(withIdentifier: "goToLobby", sender: nil)
            }
        }
    }
    
}

