//
//  BillDetailTableViewController.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit

class BillDetailTableViewController: UITableViewController {

    var viewModel = BillViewModel()
    var bill = Bill()
    
    private weak var imageCell: ImageTableViewCell!
    private var nameCell: TextFieldTableViewCell!
    private var totalCell: TextFieldTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TextFieldTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: ButtonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.cellIdentifier)
        title = bill.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPersonList",
            let detailVC = segue.destination as? PersonListViewController {
            detailVC.selectedPersons = bill.persons
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellIdentifier, for: indexPath) as? TextFieldTableViewCell else {
                return cell
            }
            
            nameCell = textFieldCell
            textFieldCell.configure(with: bill.name, placeholder: Constant.name, keyboardType: .default)
            cell = textFieldCell
        case 1:
            guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellIdentifier, for: indexPath) as? TextFieldTableViewCell else {
                return cell
            }
            
            totalCell = textFieldCell
            textFieldCell.configure(with: "\(bill.total)".replacingOccurrences(of: ".", with: ","), placeholder: Constant.amount, keyboardType: .decimalPad)
            cell = textFieldCell
        case 2:
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.cellIdentifier, for: indexPath) as? ButtonTableViewCell else {
                return cell
            }
            
            buttonCell.configure(with: Constant.save, delegate: self)
            cell = buttonCell
        default:
            break
        }
        
        return cell
    }    
    
}

extension BillDetailTableViewController: ButtonTableViewCellDelegate {
    
    func buttonTableViewCellDidTapped(_ cell: ButtonTableViewCell) {
        guard let name = nameCell.inputTextField.text, !name.isEmpty,
            let totalInput = totalCell.inputTextField.text?.replacingOccurrences(of: ",", with: "."),
            let total = Float(totalInput), total > 0
            else { return }
        
        do {
            try viewModel.updateAndSave(bill, name: name, total: total)
            navigationController?.popViewController(animated: true)
        } catch {}
    }
    
}
