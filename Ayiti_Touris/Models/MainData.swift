////
////  Main.swift
////  Ayiti_Touris
////
////  Created by Joseph Andy Feidje on 12/4/18.
////
//
//import UIKit
//
//class MainData: NSObject {
//
//    // MARK: Properties
//    var nom_category: String?
//    
//    
//    
//    init(dictionary: [String: Any]) {
//        nom_category = dictionary["nom_cagtegorie"] as! String
//    }
//    
//    class func category(dictionaries: [[String: Any]]) -> [MainData] {
//        var cat: [MainData] = []
//        let backendless = Backendless.sharedInstance()
//        let categoryStorage = backendless?.data.ofTable("categorie")
//        let queryBuilder = DataQueryBuilder()
//        queryBuilder?.setRelated(["nom_cagtegorie","objectId"])
//        
//        categoryStorage?.find(queryBuilder,response: {
//            (categoryObjects: [Any]?) -> () in
//            
//        for dictionary in dictionaries {
//            let cate = MainData(dictionary: dictionary)
//            cat.append(cate)
//        }
//        },error: {
//                                            (fault: Fault?) -> () in
//                                            print("Server reported an error: \(String(describing: fault?.message))")
//                    })
//        
//        return cat
//    }
//
//
//}
