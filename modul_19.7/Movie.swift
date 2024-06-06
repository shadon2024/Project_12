//
//  Movie.swift
//  modul_19.7
//
//  Created by Admin on 27/05/24.
//


import Foundation

struct Movie: Decodable {
    let filmId: Int
    let nameRu: String?
    let nameEn: String?
    
    var title: String {
        return nameRu ?? nameEn ?? "Без названия"
    }
    
    let posterURL: String?
    
    var profileImageUrl: URL? {
        if let posterURL = posterURL {
            return URL(string: posterURL)
        } else {
            return URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp/\(filmId).jpg")
        }
    }
    let ratingVoteCount: Int?
    let year: String?
    let type: String?
    let description: String?
    let filmLength: String?
    let rating: String?
}

struct MovieResponse: Decodable {
    let films: [Movie]
}











//        guard let posterURL = posterURL else { return nil }
//        return URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp\(posterURL)")
//        guard let posterUrl = posterURL else { return nil }
//        return URL(string: posterUrl)



//import Foundation
//
//// MARK: - PopularMoviesResponse
//struct PopularMoviesResponse: Codable {
//    let keyword: String
//    let pagesCount, searchFilmsCountResult: Int
//    let films: [Movie]
//}
//
//// MARK: - Film
//struct Movie: Codable {
//    let filmID: Int
//    let nameRu, nameEn, type, year: String
//    let description, filmLength: String
//    //let countries: [Country]
//    //let genres: [Genre]
//    let rating: String
//    let ratingVoteCount: Int
//    let posterURL: String?     // "http://kinopoiskapiunofficial.tech/images/posters/kp/263531.jpg"
//
//    var profileImageUrl: URL? {
//
//        guard let posterURL = posterURL else { return nil }
//        return URL(string: "http://kinopoiskapiunofficial.tech/images/posters/kp\(posterURL)")
//    }
//
//    let posterURLPreview: String
//
//    enum CodingKeys: String, CodingKey {
//        case filmID = "filmId"
//        case nameRu = "nameRu"
//        case nameEn = "nameEn"
//        case type = "type"
//        case year = "year"
//        case description = "description"
//        case filmLength = "filmLength"
//        case rating = "rating"
//        case ratingVoteCount = "ratingVoteCount"
//        case posterURL = "posterUrl"
//        case posterURLPreview = "posterUrlPreview"
//    }
//
//    // MARK: - Country
//    struct Country: Codable {
//        let country: String
//
//        enum Country: Int {
//        case country
//        }
//
//    }
//
//    // MARK: - Genre
//    struct Genre: Codable {
//        let genre: String
//
//        enum Genre: String {
//        case genre
//        }
//    }
//}


