//
//  MovieService.swift
//  Arbetsprov
//
//  Created by Sebastian Strus on 2025-05-09.
//

import Foundation

actor MovieService {
    private let apiKey = "64298448"

    func fetchDetail(for imdbID: String) async throws -> MovieDetail {
        let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(imdbID)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let detail = try JSONDecoder().decode(MovieDetail.self, from: data)
        return detail
    }
}

extension MovieService {
    func searchMovies(query: String) async throws -> [SearchResult] {
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(queryEncoded)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SearchResponse.self, from: data)
        return response.Search
    }
}
