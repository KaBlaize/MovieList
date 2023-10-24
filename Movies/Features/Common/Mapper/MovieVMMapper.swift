//
//  MovieVMMapper.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

enum MovieVMMapper {
    static func map(_ items: [TrendingListItem], genres: [Genre]) -> [MovieVM] {
        items.map { map($0, genres: genres) }
    }

    private static func map(_ item: TrendingListItem, genres: [Genre]) -> MovieVM {
        MovieVM(
            id: "\(item.id)",
            title: item.title,
            genres: map(genreIds: item.genreIDS, genres: genres),
            overView: item.overview,
            image: .init(
                small: "https://image.tmdb.org/t/p/w200/\(item.posterPath)", // TODO: https://developer.themoviedb.org/reference/configuration-details
                large: "https://image.tmdb.org/t/p/original/\(item.posterPath)"
            ),
            popularity: Float(item.popularity),
            isMarked: false
        )
    }

    private static func map(genreIds: [Int], genres: [Genre]) -> String {
        genreIds
            .map { map(genreId: $0, genres: genres) }
            .joined(separator: ", ")
    }

    private static func map(genreId: Int, genres: [Genre]) -> String {
        genres
            .first { $0.id == genreId }
            .map(\.name) ?? "unknown"
    }
}
