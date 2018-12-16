//
//  RestaurantsCell.swift
//  Ayiti_Touris
//
//  Created by Mac on 9/11/1397 AP.
//

import UIKit

class RestaurantsCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var ratingImgeView: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    
    @IBOutlet weak var phoneLabel: UILabel!
    
  
    @IBOutlet weak var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage.layer.cornerRadius = 16
        avatarImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
