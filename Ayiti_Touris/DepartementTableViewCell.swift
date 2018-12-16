//
//  DepartementTableViewCell.swift
//  AyitiTourisme
//
//  Created by Jetry Dumont on 11/10/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

import UIKit

class DepartementTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var departementLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myImage.layer.cornerRadius = 16
        myImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
