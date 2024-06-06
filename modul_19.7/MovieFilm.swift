//
//  MovieFilm.swift
//  modul_19.7
//
//  Created by Admin on 28/05/24.
//


import Foundation

struct MoviePoular: Decodable {
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

struct MoviePopularResponse: Decodable {
    let popularFilms: [MoviePoular]
}
































// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieFilm = try? JSONDecoder().decode(MovieFilm.self, from: jsonData)

//
//import Foundation
//
//// MARK: - MovieFilm
//struct MovieFilm: Codable {
//    let keyword: String
//    let pagesCount, searchFilmsCountResult: Int
//    let films: [Film]
//}
//
//// MARK: - Film
//struct Film: Codable {
//    let filmID: Int
//    let nameRu, nameEn, type, year: String
//    let description, filmLength: String
//    let countries: [Country]
//    let genres: [Genre]
//    let rating: String
//    let ratingVoteCount: Int
//    let posterURL: String
//    let posterURLPreview: String
//
//    enum CodingKeys: String, CodingKey {
//        case filmID = "filmId"
//        case nameRu, nameEn, type, year, description, filmLength, countries, genres, rating, ratingVoteCount
//        case posterURL = "posterUrl"
//        case posterURLPreview = "posterUrlPreview"
//    }
//}
//
//// MARK: - Country
//struct Country: Codable {
//    let country: String
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let genre: String
//}
