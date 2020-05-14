//
//  PersonDetailTableViewController.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit
import RealmSwift

class PersonDetailTableViewController: UITableViewController {

    var viewModel = PersonViewModel()
    var person = Person()
    
    private weak var imageCell: ImageTableViewCell!
    private var nameCell: TextFieldTableViewCell!
    private weak var emailCell: TextFieldTableViewCell!
    private weak var phoneCell: TextFieldTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: ImageTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ImageTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: TextFieldTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: TextFieldTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: ButtonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.cellIdentifier)
        
        title = person.name
    }
    
    private func presentImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.cellIdentifier, for: indexPath) as? ImageTableViewCell else {
                return cell
            }
                        
            if let imageData = person.imageData, let image = UIImage(data: imageData) {
                imageCell.configure(with: image)
            }
            
            imageCell.textLabel?.textAlignment = .center
            imageCell.textLabel?.text = imageCell.pictureImageView?.image == nil ? Constant.tapForAction : nil
            
            self.imageCell = imageCell
            cell = imageCell
        case 1:
            guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellIdentifier, for: indexPath) as? TextFieldTableViewCell else {
                return cell
            }
            
            nameCell = textFieldCell
            textFieldCell.configure(with: person.name, placeholder: Constant.name, keyboardType: .default)
            cell = textFieldCell
        case 2:
            guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellIdentifier, for: indexPath) as? TextFieldTableViewCell else {
                return cell
            }
            
            emailCell = textFieldCell
            textFieldCell.configure(with: person.email, placeholder: Constant.email, keyboardType: .emailAddress)
            cell = textFieldCell
        case 3:
            guard let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellIdentifier, for: indexPath) as? TextFieldTableViewCell else {
                return cell
            }
            
            phoneCell = textFieldCell
            textFieldCell.configure(with: person.phone, placeholder: Constant.phone, keyboardType: .phonePad)
            cell = textFieldCell
        case 4:
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presentImagePicker()
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 150
        default: return 50
        }
    }
    
}

extension PersonDetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let newImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
            else { return}
                
        try? viewModel.update(person, imageData: newImage.pngData())
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        picker.dismiss(animated: true)
    }
    
}

extension PersonDetailTableViewController: ButtonTableViewCellDelegate {
    
    func buttonTableViewCellDidTapped(_ cell: ButtonTableViewCell) {
        guard let name = nameCell.inputTextField.text, !name.isEmpty else { return }
        
        let email = emailCell.inputTextField.text
        let phone = phoneCell.inputTextField.text
        let imageData = imageCell.pictureImageView.image?.pngData()
        
        do {
            try viewModel.updateAndSave(person, name: name, email: email, phone: phone, imageData: imageData)
            navigationController?.popViewController(animated: true)
        } catch {}
    }
    
}
