//
//  detailMonumentViewController.swift
//  Ayiti_Touris
//
//  Created by Mac on 9/16/1397 AP.
//

import UIKit
import AlamofireImage

class detailMonumentViewController: UIViewController {
    
    @IBOutlet weak var monumentImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    
    @IBOutlet weak var informationLabel: UITextView!
    
    var Name: String?
    var imagees: URL?
    var adresse: String?
//    var telephone: String?
    var information: String?
    //var rating: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        monumentImage.af_setImage(withURL: imagees!)
        NameLabel.text = Name
        adresseLabel.text = adresse
         informationLabel.text = information
        
        //telLabel.text = telephone
        //ratingImage.af_setImage(withURL: rating!)
        

        // Do any additional setup after loading the view.
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
