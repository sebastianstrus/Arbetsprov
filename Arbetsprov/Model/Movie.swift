//
//  Movie.swift
//  Arbetsprov
//
//  Created by Sebastian Strus on 2025-05-09.
//


import Foundation

struct Movie: Codable, Identifiable, Equatable {
    let id: String          // imdbID
    let title: String       // Title
    let year: String        // Year
    let type: String        // Type (e.g., "movie" or "series")
    let posterURL: URL?     // Poster
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case posterURL = "Poster"
    }
}

struct RatedMovie: Codable {
    let title: String
    let score: Int
}

struct MovieDetail: Codable {
    let Title: String
    let Year: String
    let Genre: String
    let Plot: String
    let Poster: String
}
