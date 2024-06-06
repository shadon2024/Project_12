//
//  ApiManager.swift
//  modul_19.7
//
//  Created by Admin on 28/05/24.
//

//import Foundation
//
//class ApiManager {
//    static let shared = ApiManager()
//    
//    
//    let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword"
//    let apiKey = "8444fa56-7af6-40e6-b27f-fdbcbab43f60"
//
//    func getFilm() {
//        let url = URL(string: urlString)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            //print(response)
//            guard let data = data else { return }
//            if let movieFilm = try? JSONDecoder().decode(MovieFilm.self, from: data) {
//                print(movieFilm.films.description)
//            } else {
//                print("fail не успешно")
//            }
//        }
//        task.resume()
//    }
//}
