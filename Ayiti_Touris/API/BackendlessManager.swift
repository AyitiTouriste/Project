////
////  BackendlessManager.swift
////  Ayiti_Touris
////
////  Created by Joseph Andy Feidje on 12/4/18.
////
//
//import Foundation
//
//
//class BackendlessManager {
//    
//    
//    func retrieveCategory(completion: @escaping ([MainData]?, Error?) -> ()) {
//        let url = URL(string: MovieApiManager.baseUrl + "now_playing?api_key=\(MovieApiManager.apiKey)")!
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//        let task = session.dataTask(with: request) { (data, response, error) in
//            // This will run when the network request returns
//            if let data = data {
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
//                
//                let movies = Movie.movies(dictionaries: movieDictionaries)
//                completion(movies, nil)
////            } else {
//                completion(nil, error)
//            }
//        }
//        task.resume()
//    }
//}
