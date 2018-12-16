//
//  detailClubViewController.swift
//  Ayiti_Touris
//
//  Created by Mac on 9/16/1397 AP.
//

import UIKit
import AlamofireImage

class detailClubViewController: UIViewController {
    
    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var informationLabel: UITextView!
    @IBOutlet weak var ratingImageView: UIImageView!
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}