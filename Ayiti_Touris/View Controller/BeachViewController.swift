//
//  BeachViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class BeachViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var refreshControl: UIRefreshControl!
    
    var BeachName = [String]()
    var BeachAdd = [String]()
    var BeachTel = [String]()
    var BeachImg = [String]()
    var BeachCourrier = [String]()
    var BeachSite = [String]()
    var BeachInf = [String]()
    var BeachRating = [String]()
    var BeachReviews = [String]()
    var etoile:[Double: String] = [0.0:"stars_0",1.0:"stars_1",1.5:"stars_1half",2.0:"stars_2",2.5:"stars_2half",3:"stars_3",3.5:"stars_3half",4.0:"stars_4",4.5:"stars_4half",5.0:"stars_5"]
    
    var filteredDataName = [String]()
    var filteredDataAdd = [String]()
    var filteredDataTel = [String]()
    var filteredDataImg = [String]()
    var filteredDataCourrier = [String]()
    var filteredDataSite = [String]()
    var filteredDataInf = [String]()
    var filteredDataRating = [String]()
    var filteredDataReviews = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        retrieveBeachData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BeachViewController.didPullTorefresh(_:)) , for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func didPullTorefresh (_ refreshControl: UIRefreshControl) {
        retrieveBeachData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeachCell", for: indexPath) as! BeachCell
        
        cell.beachLabel.text = filteredDataName[indexPath.row]
        cell.avatarImage?.af_setImage(withURL: URL(string: filteredDataImg[indexPath.row])!)
        cell.addLabel.text = filteredDataAdd[indexPath.row]
        cell.phoneLabel.text = filteredDataTel[indexPath.row]
        let index = Double(filteredDataRating[indexPath.row])
        cell.ratingImage?.image = UIImage(named: etoile[index!]!)
        cell.reviewsLabel.text = "\(filteredDataReviews[indexPath.row]) Reviews"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDataName = searchText.isEmpty ? BeachName : BeachName.filter { (itemName) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let filterName = itemName
            return filterName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        performSegue(withIdentifier: "detailBeachSegue", sender: self)
    }
    func retrieveBeachData(){
        SVProgressHUD.show()
        let backendless = Backendless.sharedInstance()
        let categoryStorage = backendless?.data.ofTable("lieu_touristique")
        let queryBuilder = DataQueryBuilder()
        //        queryBuilder!.setRelated(["nom_cagtegorie","nom_cagtegorie.lieu_touristique"])
        // set where clause
        let whereClause = "id_categorie = 'C7DF1BC2-1813-4105-FF13-6BACA046A700'"
        queryBuilder?.setWhereClause(whereClause)
        
        categoryStorage?.find(queryBuilder,response: {(categoryObjects: [Any]?) -> () in
            for index in 0..<categoryObjects!.count{
                let catArray = categoryObjects![index] as! [String: Any]
                let catName = String(describing: catArray["nom"]!)
                let catAdd = String(describing: catArray["adresse"]!)
                let catTel = String(describing: catArray["telephone"]!)
                let catImg = String(describing: catArray["image1"]!)
                let catCourrier = String(describing: catArray["email"]!)
                let catSite = String(describing: catArray["siteweb"]!)
                let catInf = String(describing: catArray["information"]!)
                let catRating = String(describing: catArray["etoile"]!)
                let catReviews = String(describing: catArray["reviews"]!)

                self.BeachName.append(catName)
                self.BeachAdd.append(catAdd)
                self.BeachTel.append(catTel)
                self.BeachImg.append(catImg)
                self.BeachCourrier.append(catCourrier)
                self.BeachSite.append(catSite)
                self.BeachInf.append(catInf)
                self.BeachRating.append(catRating)
                self.BeachReviews.append(catReviews)
                
                self.filteredDataName = self.BeachName
                self.filteredDataAdd = self.BeachAdd
                self.filteredDataTel = self.BeachTel
                self.filteredDataImg = self.BeachImg
                self.filteredDataCourrier = self.BeachCourrier
                self.filteredDataSite = self.BeachSite
                self.filteredDataInf = self.BeachInf
                self.filteredDataRating = self.BeachRating
                self.filteredDataReviews = self.BeachReviews
                
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
        let cell = sender as! BeachCell
        let index = tableView.indexPath(for: cell)
        let detailSegue = segue.destination as! detailBeachViewController
        detailSegue.imagees = URL(string: BeachImg[(index?.row)!])
        detailSegue.Name = BeachName[(index?.row)!]
        detailSegue.adresse = BeachAdd[(index?.row)!]
        detailSegue.telephone = BeachTel[(index?.row)!]
        detailSegue.email = BeachCourrier[(index?.row)!]
        detailSegue.site = BeachSite[(index?.row)!]
        detailSegue.information = BeachInf[(index?.row)!]
        // detailSegue.rating = URL(string: HotelRating[(index?.row)!])
        }
        else{
            
        }
    }
    

}
