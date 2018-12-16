//
//  MonumentsViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class MonumentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
     var refreshControl: UIRefreshControl!
    var MonumentName = [String]()
    var MonumentAdd  = [String]()
//    var MonumentTel  = [String]()
    var MonumentImg  = [String]()
    var MonumentInf  = [String]()
    
    var filteredDataName = [String]()
    var filteredDataAdd = [String]()
//    var filteredDataTel = [String]()
    var filteredDataImg = [String]()
    var filteredDataInf = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        retrieveMonumentData()
        tableView.reloadData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HotelsViewController.didPullTorefresh(_:)) , for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func didPullTorefresh (_ refreshControl: UIRefreshControl) {
        retrieveMonumentData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonumentsCell", for: indexPath) as! MonumentsCell
        
        cell.monumentsLabel.text = filteredDataName[indexPath.row]
        cell.avatarImage?.af_setImage(withURL: URL(string: filteredDataImg[indexPath.row])!)
        cell.addLabel.text = filteredDataAdd[indexPath.row]
        
//        cell.ratingImage?.image = UIImage(imageLiteralResourceName: filteredData[indexPath.row])
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDataName = searchText.isEmpty ? MonumentName : MonumentName.filter { (itemName) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let filterName = itemName
            return filterName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        performSegue(withIdentifier: "detailMonumentSegue", sender: self)
    }
    func retrieveMonumentData(){
        SVProgressHUD.show()
        let backendless = Backendless.sharedInstance()
        let categoryStorage = backendless?.data.ofTable("lieu_touristique")
        let queryBuilder = DataQueryBuilder()
        //        queryBuilder!.setRelated(["nom_cagtegorie","nom_cagtegorie.lieu_touristique"])
        // set where clause
        let whereClause = "id_categorie = '8BA8DFEE-08FB-3128-FFDF-69E1F8EFEF00'"
        queryBuilder?.setWhereClause(whereClause)
        
        categoryStorage?.find(queryBuilder,response: {(categoryObjects: [Any]?) -> () in
            for index in 0..<categoryObjects!.count{
                let catArray = categoryObjects![index] as! [String: Any]
                let catName = String(describing: catArray["nom"]!)
                let catAdd = String(describing: catArray["adresse"]!)
//                let catTel = String(describing: catArray["telephone"]!)
                let catImg = String(describing: catArray["image1"]!)
                let catInf = String(describing: catArray["information"]!)
                //let catRating = String(describing: catArray["etoile"]!)
        self.MonumentName.append(catName)
                self.MonumentAdd.append(catAdd)
//                self.HotelTel.append(catTel)
                self.MonumentImg.append(catImg)
                
                self.MonumentInf.append(catInf)
                //self.HotelRating.append(catRating)
                
                self.filteredDataName = self.MonumentName
                self.filteredDataAdd = self.MonumentAdd
//                self.filteredDataTel = self.HotelTel
                self.filteredDataImg = self.MonumentImg
                
                
                self.filteredDataInf = self.MonumentInf
                // self.filteredDataRating = self.HotelRating
                self.tableView.reloadData()
               self.refreshControl.endRefreshing()
            }
            SVProgressHUD.dismiss()
        },
                              error: {
                                (fault: Fault?) -> () in
                                print("Server reported an error: \(String(describing: fault?.message))")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "backToFirstSegue" {
        let cell = sender as! MonumentsCell
        let index = tableView.indexPath(for: cell)
        let detailSegue = segue.destination as! detailMonumentViewController
        detailSegue.imagees = URL(string: MonumentImg[(index?.row)!])
        detailSegue.Name = MonumentName[(index?.row)!]
        detailSegue.adresse = MonumentAdd[(index?.row)!]
//        detailSegue.telephone = HotelTel[(index?.row)!]
        
        detailSegue.information = MonumentInf[(index?.row)!]
        // detailSegue.rating = URL(string: HotelRating[(index?.row)!])
    }
        else{
            
        }
    }
   

}
