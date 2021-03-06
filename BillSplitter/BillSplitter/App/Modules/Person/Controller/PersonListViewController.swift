//
//  PersonListViewController.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

class PersonListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var viewModel = PersonViewModel()
    private var persons: Results<Person>? {
        didSet {
            tableview.reloadData()
        }
    }
    
    var bill: Bill?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        persons = try? viewModel.persons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPersonDetail",
            let detailVC = segue.destination as? PersonDetailTableViewController,
            let person = sender as? Person {
            detailVC.person = person
        }
    }
    
}

// MARK: - Table view data source

extension PersonListViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let persons = persons else {
            return UITableViewCell()
        }
            
        let person = persons[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = person.name
        
        if let imageData = person.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        if let bill = bill,
            bill.persons.contains(person) {
            cell.accessoryType = .checkmark            
            cell.detailTextLabel?.text = "$ \(bill.total/Float(bill.persons.count))"
        } else {
            cell.accessoryType = .none
            cell.detailTextLabel?.text = "$ 0.0"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let persons = persons else { return }
        
        if editingStyle == .delete {
            let person = persons[indexPath.row]
            do {
                try viewModel.delete(person)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {}
        }
    }
    
}

extension PersonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let persons = persons else { return }
        let person = persons[indexPath.row]
        
        if let selectedPersons = bill?.persons {
            do {
                let realm = try Realm()
                try realm.write() {
                    if let currentIndex = selectedPersons.index(of: person) {
                        selectedPersons.remove(at: currentIndex)
                    } else {
                        selectedPersons.insert(person, at: 0)
                    }
                }
                tableView.reloadData()
            } catch {}
        } else {
            performSegue(withIdentifier: "goToPersonDetail", sender: person)
        }
    }
    
}
