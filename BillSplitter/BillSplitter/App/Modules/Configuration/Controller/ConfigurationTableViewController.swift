//
//  ConfigurationTableViewController.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

class ConfigurationTableViewController: UITableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "configurationCell", for: indexPath)
        cell.textLabel?.textAlignment = .center
        
        switch indexPath.row {
        case 1:
            cell.textLabel?.text = Constant.cleanDatabase
        case 2:
            cell.textLabel?.text = Constant.closeSession
        case 4:
            cell.textLabel?.text = Constant.credits
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let realm = try? Realm()
            try? realm?.write {
                realm?.deleteAll()
            }
        case 2:
            parent?.dismiss(animated: true)
        default: break
        }
    }

}
