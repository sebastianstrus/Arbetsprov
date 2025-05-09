//
//  MainView.swift
//  Arbetsprov
//
//  Created by Sebastian Strus on 2025-05-09.
//

import SwiftUI

@MainActor
struct MainView: View {
    @State private var searchText = ""
    @State private var searchResults: [SearchResult] = []
    @State private var ratedMovieIDs: [String: RatingStore.RatedMovie] = [:]


    private let service = MovieService()
    private let store: RatingStore

    init(store: RatingStore) {
        self.store = store
    }

    var body: some View {
        NavigationStack {
            List {
                Section("Sök resultat") {
                    ForEach(searchResults, id: \.imdbID) { movie in
                        NavigationLink(movie.Title) {
                            MovieDetailView(imdbID: movie.imdbID, store: store)
                        }
                    }
                }

                Section("Tidigare betygsatta") {
                    ForEach(ratedMovieIDs.sorted(by: { $0.key < $1.key }), id: \.key) { _, rated in
                        HStack {
                            Text(rated.title)
                            Spacer()
                            Text("Betyg: \(rated.score)")
                        }
                    }
                }

            }
            .navigationTitle("Filmbetyg")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                Task {
                    await search()
                }
            }
            .onAppear {
                Task {
                    self.ratedMovieIDs = await store.getAllRatings()
                }
            }
        }
    }

    private func search() async {
        do {
            self.searchResults = try await service.searchMovies(query: searchText)
        } catch {
            print("Search error: \(error)")
        }
    }
}
