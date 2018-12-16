//
//  RestaurantsViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var RestaurantName = [String]()
    var RestaurantAdd = [String]()
    var RestaurantTel = [String]()
    var RestaurantImg = [String]()
    var RestaurantCourrier = [String]()
    var RestaurantSite = [String]()
    var RestaurantInf = [String]()
    var RestaurantRating = [String]()
    var RestaurantReviews = [String]()
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
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        retrieveRestaurantsData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantsCell", for: indexPath) as! RestaurantsCell
        cell.restLabel.text = filteredDataName[indexPath.row]
        cell.avatarImage?.af_setImage(withURL: URL(string: filteredDataImg[indexPath.row])!)
        cell.addLabel.text = filteredDataAdd[indexPath.row]
        cell.phoneLabel.text = filteredDataTel[indexPath.row]
        let index = Double(filteredDataRating[indexPath.row])
        cell.ratingImageView?.image = UIImage(named: etoile[index!]!)
        cell.reviewsLabel.text = "\(filteredDataReviews[indexPath.row]) Reviews"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDataName = searchText.isEmpty ? RestaurantName : RestaurantName.filter { (item) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let lt = item
            return lt.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
//        performSegue(withIdentifier: "detailRestoSegue", sender: self)
        print("-------------------the details")
    }
    
    func retrieveRestaurantsData(){
        SVProgressHUD.show()
        let backendless = Backendless.sharedInstance()
        let categoryStorage = backendless?.data.ofTable("lieu_touristique")
        let queryBuilder = DataQueryBuilder()
        //        queryBuilder!.setRelated(["nom_cagtegorie","nom_cagtegorie.lieu_touristique"])
        // set where clause
        let whereClause = "id_categorie = '7821C5A6-8AE2-9D53-FF08-76AC61630900'"
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
                
                self.RestaurantName.append(catName)
                self.RestaurantAdd.append(catAdd)
                self.RestaurantTel.append(catTel)
                self.RestaurantImg.append(catImg)
                self.RestaurantCourrier.append(catCourrier)
                self.RestaurantSite.append(catSite)
                self.RestaurantInf.append(catInf)
                self.RestaurantRating.append(catRating)
                self.RestaurantReviews.append(catReviews)
                
                self.filteredDataName = self.RestaurantName
                self.filteredDataAdd = self.RestaurantAdd
                self.filteredDataTel = self.RestaurantTel
                self.filteredDataImg = self.RestaurantImg
                self.filteredDataCourrier = self.RestaurantCourrier
                self.filteredDataSite = self.RestaurantSite
                self.filteredDataInf = self.RestaurantInf
                self.filteredDataRating = self.RestaurantRating
                self.filteredDataReviews = self.RestaurantReviews
                
                self.tableView.reloadData()
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
        let cell = sender as! RestaurantsCell
        let index = tableView.indexPath(for: cell)
        let detailSegue = segue.destination as! detailRestaurantViewController
        detailSegue.imagees = URL(string: RestaurantImg[(index?.row)!])
        detailSegue.Name = RestaurantName[(index?.row)!]
        detailSegue.adresse = RestaurantAdd[(index?.row)!]
        detailSegue.telephone = RestaurantTel[(index?.row)!]
        detailSegue.email = RestaurantCourrier[(index?.row)!]
        detailSegue.site = RestaurantSite[(index?.row)!]
        detailSegue.information = RestaurantInf[(index?.row)!]
        detailSegue.ratingImagees = etoile[Double(RestaurantRating[(index?.row)!])!]
        }
        else{
            
        }
    }
    
}
