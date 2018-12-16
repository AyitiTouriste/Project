//
//  ClubsViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class ClubsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var refreshControl: UIRefreshControl!
    
    var ClubName = [String]()
    var ClubAdd = [String]()
    var ClubTel = [String]()
    var ClubImg = [String]()
    var ClubCourrier = [String]()
    var ClubSite = [String]()
    var ClubInf = [String]()
    var ClubRating = [String]()
    var ClubReviews = [String]()
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
        tableView.reloadData()
        retrieveClubData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HotelsViewController.didPullTorefresh(_:)) , for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func didPullTorefresh (_ refreshControl: UIRefreshControl) {
        retrieveClubData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClubsCell", for: indexPath) as! ClubsCell
      
        cell.clubLabel.text = filteredDataName[indexPath.row]
        cell.avatarImage?.af_setImage(withURL: URL(string: filteredDataImg[indexPath.row])!)
        cell.addLabel.text = filteredDataAdd[indexPath.row]
        cell.phoneLabel.text = filteredDataTel[indexPath.row]
        let index = Double(filteredDataRating[indexPath.row])
        cell.ratingImage?.image = UIImage(named: etoile[index!]!)
        cell.reviewsLabel.text = "\(filteredDataReviews[indexPath.row]) Reviews"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         filteredDataName = searchText.isEmpty ?
        ClubName: ClubName.filter { (itemName) -> Bool in
            let filterName = itemName
            return filterName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    

   
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        performSegue(withIdentifier: "detailClubSegue", sender: self)
    }
    func retrieveClubData(){
        SVProgressHUD.show()
        let backendless = Backendless.sharedInstance()
        let categoryStorage = backendless?.data.ofTable("lieu_touristique")
        let queryBuilder = DataQueryBuilder()
        //        queryBuilder!.setRelated(["nom_cagtegorie","nom_cagtegorie.lieu_touristique"])
        // set where clause
        let whereClause = "id_categorie = 'B60B980E-D5F7-3554-FF31-22A25ACC3000'"
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
                
                self.ClubName.append(catName)
                self.ClubAdd.append(catAdd)
                self.ClubTel.append(catTel)
                self.ClubImg.append(catImg)
                self.ClubCourrier.append(catCourrier)
                self.ClubSite.append(catSite)
                self.ClubInf.append(catInf)
                self.ClubRating.append(catRating)
                self.ClubReviews.append(catReviews)
                
                self.filteredDataName = self.ClubName
                self.filteredDataAdd = self.ClubAdd
                self.filteredDataTel = self.ClubTel
                self.filteredDataImg = self.ClubImg
                self.filteredDataCourrier = self.ClubCourrier
                self.filteredDataSite = self.ClubSite
                self.filteredDataInf = self.ClubInf
                self.filteredDataRating = self.ClubRating
                self.filteredDataReviews = self.ClubReviews
                
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
        
        let cell = sender as! ClubsCell
        let index = tableView.indexPath(for: cell)
        let detailSegue = segue.destination as! detailClubViewController
        detailSegue.imagees = URL(string: ClubImg[(index?.row)!])
        detailSegue.Name = ClubName[(index?.row)!]
        detailSegue.adresse = ClubAdd[(index?.row)!]
        detailSegue.telephone = ClubTel[(index?.row)!]
        detailSegue.email = ClubCourrier[(index?.row)!]
        detailSegue.site = ClubSite[(index?.row)!]
        detailSegue.information = ClubInf[(index?.row)!]
        // detailSegue.rating = URL(string: HotelRating[(index?.row)!])
    }
    
}
