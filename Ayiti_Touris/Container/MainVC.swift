//
//  MainVC.swift
//  AyitiTourisme
//
//  Created by Abraham Asmile on 30/10/18.
//  Copyright © 2018 Abraham Asmile. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var name = ["port-au-prince", "cap-haitien", "hinche", "jeremie", "gonaives", "fort-liberte"]
    
    var nameWithDesc = ["port-au-prince":"Capitale D'haïti et chef lieu du département de L'Ouest  2 470 762 habitants", "cap-haitien":"Cap-Haitien est le chef lieu du département du nord 186 251 haibitants", "hinche":"Hinche est le chef lieu du département du centre 23 580 habitants", "jeremie":"Jérémie est le chef lieu du département de la Grand-Anse 31 000 habitants", "gonaives":"Gonaïves est le chef lieu du département de l'artibonite 31 000 habitants", "fort-liberte":"Fort-liberté est le chef lieu du département de l'artibonite 17 000 habitants"]
  
    var name_vs_DepId = ["port-au-prince":"3FC8151D-EE4F-9701-FF04-DB3C5EF12400", "cap-haitien":"A617C17C-DD5A-7D34-FFA1-5542379C1200", "hinche":"4CDE570B-15E4-A0F5-FF57-34A0E4F6FA00", "jeremie":"8388EC45-929D-F531-FFE7-087A9592FB00", "gonaives":"F069DBA9-8BDE-AF7E-FFA8-8E7F00212300", "fort-liberte":"C23A42C8-1F45-6D48-FF41-2ADB2A51FA00"]
    
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.rowHeight = 130
        TableView.estimatedRowHeight = 140

//
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(showProfile),
//                                               name: NSNotification.Name("ShowProfile"),
//                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showFavorites),
                                               name: NSNotification.Name("ShowFavorites"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHistory),
                                               name: NSNotification.Name("ShowHistory"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSignIn),
                                               name: NSNotification.Name("ShowSignIn"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showReviews),
                                               name: NSNotification.Name("ShowReviews"),
                                               object: nil)
        
       
    }
    
//    @objc func showProfile() {
//        performSegue(withIdentifier: "ShowProfile", sender: nil)
//    }
    @objc func showFavorites() {
        performSegue(withIdentifier: "ShowFavorites", sender: nil)
    }
    
    @objc func showHistory() {
        performSegue(withIdentifier: "ShowHistory", sender: nil)
    }
    
    @objc func showSignIn() {
        performSegue(withIdentifier: "ShowSignIn", sender: nil)
    }
    @objc func showReviews() {
        performSegue(withIdentifier: "ShowReviews", sender: nil)
    }
    
    @IBAction func onDidTap(_ sender: UITapGestureRecognizer) {
        print("Tap-------------")
    }
    
    @IBAction func onMoreTapped() {
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartementTableViewCell", for: indexPath)as? DepartementTableViewCell
        cell?.myImage?.image = UIImage(named: name[indexPath.row])
        cell?.departementLabel.text = nameWithDesc[name[indexPath.row]]
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabSegue" {
            let cell = sender as! DepartementTableViewCell
            let indexPath = TableView.indexPath(for: cell)
            let otherSegue = segue.destination as! TabBarViewController
            otherSegue.depID = name_vs_DepId[name[(indexPath?.row)!]]!
        }
    }
    
   
}


