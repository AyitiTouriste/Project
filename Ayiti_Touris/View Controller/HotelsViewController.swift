//
//  HotelsViewController.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 11/20/2018 AP.
//

import UIKit
import AlamofireImage
import SVProgressHUD


class HotelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var refreshControl: UIRefreshControl!
    var depID: String?
    
    
    var HotelName = [String]()
    var HotelAdd = [String]()
    var HotelTel = [String]()
    var HotelImg = [String]()
    var HotelCourrier = [String]()
    var HotelSite = [String]()
    var HotelInf = [String]()
    var HotelRating = [String]()
    var HotelReviews = [String]()
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
        retrieveHotelData()
        tableView.rowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HotelsViewController.didPullTorefresh(_:)) , for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
//        print("print via hotelcontroller------------------------>>>>>>>> ",depID!)
    }

    @objc func didPullTorefresh (_ refreshControl: UIRefreshControl) {
    retrieveHotelData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotelsCell", for: indexPath) as! HotelsCell
            
        cell.hotLabel.text = filteredDataName[indexPath.row]
        cell.avatarImage?.af_setImage(withURL: URL(string: filteredDataImg[indexPath.row])!)
        cell.addLabel.text = filteredDataAdd[indexPath.row]
        cell.phoneLabel.text = filteredDataTel[indexPath.row]
        let index = Double(filteredDataRating[indexPath.row])
        cell.rantingImageView?.image = UIImage(named: etoile[index!]!)
        cell.reviewsLabel.text = "\(filteredDataReviews[indexPath.row]) Reviews"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDataName = searchText.isEmpty ? HotelName: HotelName.filter { (itemName) -> Bool in
            let filterName = itemName
            return filterName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        performSegue(withIdentifier: "detailHotelSegue", sender: self)
    }
    
    func retrieveHotelData(){
        SVProgressHUD.show()
        let backendless = Backendless.sharedInstance()
        let categoryStorage = backendless?.data.ofTable("lieu_touristique")
        let queryBuilder = DataQueryBuilder()
//        queryBuilder!.setRelated(["departement[lieux_touristique_x_dep]"])
        // set where clause
        let whereClause = "id_categorie = 'F48DD318-B096-F8A2-FF95-47284708F700' and lieux_x_dep= '70EF0032-78FE-23C9-FF30-03702BBC6000'"
        
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
                
                self.HotelName.append(catName)
                self.HotelAdd.append(catAdd)
                self.HotelTel.append(catTel)
                self.HotelImg.append(catImg)
                self.HotelCourrier.append(catCourrier)
                self.HotelSite.append(catSite)
                self.HotelInf.append(catInf)
                self.HotelRating.append(catRating)
                self.HotelReviews.append(catReviews)
                
                
                self.filteredDataName = self.HotelName
                self.filteredDataAdd = self.HotelAdd
                self.filteredDataTel = self.HotelTel
                self.filteredDataImg = self.HotelImg
                self.filteredDataCourrier = self.HotelCourrier
                self.filteredDataSite = self.HotelSite
                self.filteredDataInf = self.HotelInf
                self.filteredDataRating = self.HotelRating
                self.filteredDataReviews = self.HotelReviews
                
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
        if segue.identifier != "backToFirstSegue"{
        let cell = sender as! HotelsCell
        let index = tableView.indexPath(for: cell)
        let detailSegue = segue.destination as! detailHotelViewController
        detailSegue.imagees = URL(string: HotelImg[(index?.row)!])
        detailSegue.Name = HotelName[(index?.row)!]
        detailSegue.adresse = HotelAdd[(index?.row)!]
        detailSegue.telephone = HotelTel[(index?.row)!]
        detailSegue.email = HotelCourrier[(index?.row)!]
        detailSegue.site = HotelSite[(index?.row)!]
        detailSegue.information = HotelInf[(index?.row)!]
        detailSegue.ratingImagees = etoile[Double(HotelRating[(index?.row)!])!]
            
    }
        else{
            
        }
    }
    
    func networkErrorAlert(){
        let alertController = UIAlertController(title: "Network Error", message: "It's Seems there is a network error. Please try again later.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (action) in self.retrieveHotelData()}))
        self.present(alertController, animated: true)
    }
    
}
    
    

   
    
    

