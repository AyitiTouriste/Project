//
//  EventsViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 11/20/2018.
//

import UIKit
import SVProgressHUD

class EventsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
       
//        var URL = NSURL(string: "https://web.facebook.com/partyinginhaiti/?_rdc=1&_rdr")
        let URL = NSURL(string: "https:www.instagram.com/partyinginhaiti/"); webView.loadRequest(NSURLRequest(url: URL! as URL) as URLRequest)
        SVProgressHUD.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
