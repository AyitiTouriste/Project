//
//  PortauPrinceViewController.swift
//  AyitiTourisme
//
//  Created by Jetry Dumont on 11/11/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

import UIKit

class PortauPrinceViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var imagees = UIImage()
    var category = [String]()
    var filteredData = [String]()
    var titleVar: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 105
        self.title = titleVar
        tableView.delegate = self
        tableView.dataSource = self
        filteredData = category
        searchbar.delegate = self
        detailImage.image = imagees
        retrieveCategoryData()
        tableView.reloadData()
        tableView.rowHeight = 90
        tableView.separatorStyle = .none
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func retrieveCategoryData(){
        let backendless = Backendless.sharedInstance()
        let categoryStorage = backendless?.data.ofTable("categorie")
        let queryBuilder = DataQueryBuilder()
        queryBuilder?.setRelated(["nom_cagtegorie","objectId"])
        // set where clause
        //        queryBuilder?.setWhereClause("")
        // set related columns
        //        queryBuilder?.addRelated("nom_categorie")
        //        queryBuilder?.addRelated("objectId")
        
        // requesting sorting
        //        let sortBy = ["objectId"]
        //        queryBuilder?.setSortBy(sortBy)
        // set offset and page size
        //        queryBuilder?.setPageSize(20)
        //        queryBuilder?.setOffset(40)
        
        categoryStorage?.find(queryBuilder,response: {
            (categoryObjects: [Any]?) -> () in
            //                                print("category object-----  ",categoryObjects!)
            for index in 0..<categoryObjects!.count{
                let catArray = categoryObjects![index] as! [String: Any]
                let cat = String(describing: catArray["nom_cagtegorie"]!)
//                print(cat)
                self.category.append(cat)
                self.filteredData.append(cat)
                self.tableView.reloadData()
                print("category count-------",self.category.count)
            }
            
        },
                              error: {
                                (fault: Fault?) -> () in
                                print("Server reported an error: \(String(describing: fault?.message))")
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath) as! categoryTableViewCell
        print(category)
        cell.catLabel.text = filteredData[indexPath.row]
        cell.catImageView?.image = UIImage(imageLiteralResourceName: filteredData[indexPath.row])
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? category : category.filter { (item) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let lt = item
            return lt.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
//        view.endEditing(true)
        print("tap yess---------------------------")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HotelSegue" {
            print("yes------------------------------>> Hotel")
        }
    }
    
}
