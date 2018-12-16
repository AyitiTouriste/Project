//
//  categoryTableViewCell.swift
//  Ayiti_Touris
//
//  Created by Joseph Andy Feidje on 11/30/18.
//

import UIKit

class categoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
