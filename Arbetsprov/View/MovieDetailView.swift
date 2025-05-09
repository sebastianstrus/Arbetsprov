//
//  MovieDetailView.swift
//  Arbetsprov
//
//  Created by Sebastian Strus on 2025-05-09.
//

import SwiftUI

@MainActor
struct MovieDetailView: View {
    let imdbID: String
    @State private var detail: MovieDetail?
    @State private var score = 5

    private let service = MovieService()
    private let store: RatingStore

    init(imdbID: String, store: RatingStore) {
        self.imdbID = imdbID
        self.store = store
    }

    var body: some View {
        ScrollView {
            if let detail = detail {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: detail.Poster)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)

                    Text(detail.Title)
                        .font(.title)
                    Text(detail.Genre)
                        .font(.subheadline)
                    Text(detail.Plot)
                        .font(.body)

                    Stepper("Betyg: \(score)", value: $score, in: 1...10)

                    Button("Spara betyg") {
                        Task {
                            await store.rate(movieID: imdbID, title: detail.Title, score: score)
                        }
                    }

                }
                .padding()
            } else {
                ProgressView()
                    .onAppear {
                        Task {
                            detail = try? await service.fetchDetail(for: imdbID)
                        }
                    }
            }
        }
        .navigationTitle("Detaljer")
    }
}
