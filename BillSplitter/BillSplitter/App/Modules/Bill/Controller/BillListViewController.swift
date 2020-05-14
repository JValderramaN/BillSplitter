//
//  BillListViewController.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

class BillListViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var viewModel = BillViewModel()
    private var bills: Results<Bill>? {
        didSet {
            tableview.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bills = try? viewModel.bills()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBillDetail",
            let detailVC = segue.destination as? BillDetailTableViewController,
            let bill = sender as? Bill {
            detailVC.bill = bill
        }
    }
    
}

// MARK: - Table view data source

extension BillListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let bills = bills else {
            return UITableViewCell()
        }
        
        let bill = bills[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath)
        cell.textLabel?.text = bill.name
        cell.detailTextLabel?.text = "$ \(bill.total)".replacingOccurrences(of: ".", with: ",")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let bills = bills else { return }
        
        if editingStyle == .delete {
            let bill = bills[indexPath.row]
            do {
                try viewModel.delete(bill)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {}
        }
    }
    
}

extension BillListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let bills = bills else { return }
        performSegue(withIdentifier: "goToBillDetail", sender: bills[indexPath.row])
    }
    
}
