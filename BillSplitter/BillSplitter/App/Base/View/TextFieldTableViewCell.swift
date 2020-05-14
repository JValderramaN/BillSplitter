//
//  TextFieldTableViewCell.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let cellIdentifier = "TextFieldTableViewCell"
    @IBOutlet weak var inputTextField: UITextField!
    
    func configure(with text: String?, placeholder: String?, keyboardType: UIKeyboardType) {
        inputTextField.text = text
        inputTextField.placeholder = placeholder
        inputTextField.keyboardType = keyboardType
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
