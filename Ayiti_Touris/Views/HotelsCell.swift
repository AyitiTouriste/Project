//
//  HotelsCell.swift
//  Ayiti_Touris
//
//Created by
//Abraham Asmile on 12/1/2018 AP.
//

import UIKit

class HotelsCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var hotLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var rantingImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    
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
