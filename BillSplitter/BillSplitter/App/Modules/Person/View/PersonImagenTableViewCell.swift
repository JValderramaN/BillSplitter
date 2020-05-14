//
//  ImageTableViewCell.swift
//  BillSplitter
//
//  Created by José Valderrama on 13/05/2020.
//  Copyright © 2020 José Valderrama. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!

    func configure(with image: UIImage?) {
        pictureImageView.image = image
    }
    
}
