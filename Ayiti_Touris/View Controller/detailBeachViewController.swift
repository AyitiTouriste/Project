//
//  detailBeachViewController.swift
//  Ayiti_Touris
//
//  Created by Mac on 9/16/1397 AP.
//

import UIKit
import AlamofireImage

class detailBeachViewController: UIViewController {
    
    @IBOutlet weak var clubImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var informationLabel: UITextView!
    
    var Name: String?
    var imagees: URL?
    var adresse: String?
    var telephone: String?
    var email: String?
    var site: String?
    var information: String?
    //var rating: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubImage.af_setImage(withURL: imagees!)
        NameLabel.text = Name
        adresseLabel.text = adresse
        telLabel.text = telephone
        emailLabel.text = email
        siteLabel.text = site
        informationLabel.text = information
        //ratingImage.af_setImage(withURL: rating!)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
