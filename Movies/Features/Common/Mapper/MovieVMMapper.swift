//
//  MovieVMMapper.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

enum MovieVMMapper {
    static func map(_ itemms: [TrendingListItem]) -> [MovieVM] {
        itemms.map { map($0) }
    }

    static func map(_ item: TrendingListItem) -> MovieVM {
        MovieVM(
            id: "\(item.id)",
            title: item.title,
            genres: item
                .genreIDS
                .map { "\($0)" }
                .joined(separator: ", "),
            overView: item.overview,
            image: .init(
                small: "https://image.tmdb.org/t/p/w200/\(item.posterPath)", // TODO: https://developer.themoviedb.org/reference/configuration-details
                large: "https://image.tmdb.org/t/p/original/\(item.posterPath)"
            ),
            popularity: Float(item.popularity),
            isMarked: false
        )
    }
}
