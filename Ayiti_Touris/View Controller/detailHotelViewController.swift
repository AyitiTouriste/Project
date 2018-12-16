//
//  detailHotelViewController.swift
//  Ayiti_Touris
//
//  Created by Joseph Andy Feidje on 12/5/18.
//

import UIKit
import AlamofireImage

class detailHotelViewController: UIViewController {

    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
   @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var informationLabel: UITextView!
    
    
    var Name: String?
    var imagees: URL?
    var adresse: String?
    var telephone: String?
    var email: String?
    var site: String?
    var information: String?
    var ratingImagees: String?
    
    //var rating: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelImage.af_setImage(withURL: imagees!)
        NameLabel.text = Name
        adresseLabel.text = adresse
        telLabel.text = telephone
        emailLabel.text = email
        siteLabel.text = site
        informationLabel.text = information
        ratingImage.image = UIImage(named: ratingImagees!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
