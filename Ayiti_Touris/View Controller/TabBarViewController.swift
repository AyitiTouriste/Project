//
//  TabBarViewController.swift
//  Ayiti_Touris
//
//  Created by Joseph Andy Feidje on 12/3/18.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate{

    @IBOutlet weak var tabBarS: UITabBar!
    var imageVariable: UIImage?
    var textLabel: String?
    var depID: String?
    var items: [UITabBarItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let HotelVC = HotelsViewController()
        HotelVC.depID = depID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item*********************************************************************************-------->> ",depID!)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("shouled Select------------------------------------------------------------------------------>>>>> ",depID!)
        
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Did Select---------------------------------------------------------------------------------->>>>> ",depID!)
    }
//     MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("--------------------------------------------->>>>>>>>>>>")
    }
    
    

}
