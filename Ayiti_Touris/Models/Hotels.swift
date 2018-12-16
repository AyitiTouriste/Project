//
//  Hotels.swift
//  Ayiti_Touris
//
//  Created by Abraham Asmile on 12/1/2018 AP.
//

import Foundation

class Hotels: NSObject {
    
    // MARK: Properties
    var category: [String] = []
    var filteredData: [String] = []
    
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
            }
            
        },
                              error: {
                                (fault: Fault?) -> () in
                                print("Server reported an error: \(String(describing: fault?.message))")
        })
    }

}
