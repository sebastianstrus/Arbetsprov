//
//  RatingStore.swift
//  Arbetsprov
//
//  Created by Sebastian Strus on 2025-05-09.
//

import Foundation

actor RatingStore {
    private let storageKey = "rated_movies"
    private var ratings: [String: RatedMovie] = [:]  // imdbID -> RatedMovie

    struct RatedMovie: Codable {
        let title: String
        let score: Int
    }

    init() {
        Task {
            await load()
        }
    }

    func rate(movieID: String, title: String, score: Int) {
        ratings[movieID] = RatedMovie(title: title, score: score)
        save()
    }

    func getRating(for movieID: String) -> RatedMovie? {
        return ratings[movieID]
    }

    func getAllRatings() -> [String: RatedMovie] {
        return ratings
    }

    private func save() {
        if let data = try? JSONEncoder().encode(ratings) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let savedRatings = try? JSONDecoder().decode([String: RatedMovie].self, from: data) {
            ratings = savedRatings
        }
    }
}
