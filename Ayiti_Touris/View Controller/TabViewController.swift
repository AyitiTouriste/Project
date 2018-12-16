//
//  TabViewController.swift
//  Ayiti_Touris
//
//  Created by Mac on 9/12/1397 AP.
//

import UIKit

class TabViewController: UITabBarController {
    var departementImageView: UIImage?
    var decriptionLabel: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("label",decriptionLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("0000000000000000")
        
        
    }
}
