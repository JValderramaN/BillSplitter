//
//  ButtonTableViewCell.swift
//  BillSplitter
//
//  Created by José Valderrama on 14/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    func buttonTableViewCellDidTapped(_ cell: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {

    static let cellIdentifier = "ButtonTableViewCell"
    @IBOutlet weak var actionButton: UIButton!
    weak var delegate: ButtonTableViewCellDelegate?
    
    func configure(with title: String?, delegate: ButtonTableViewCellDelegate) {
        actionButton.setTitle(title, for: .normal)
        self.delegate = delegate
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        delegate?.buttonTableViewCellDidTapped(self)
    }
    
}
