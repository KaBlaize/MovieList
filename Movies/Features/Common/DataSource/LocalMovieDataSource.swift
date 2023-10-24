//
//  LocalMovieDataSource.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

protocol LocalMovieDataSource {
    func getTrending() -> [MovieVM]?
    func setTrending(movies: [MovieVM])
}

final class LocalMovieDataSourceImpl {
    private var movieList: [MovieVM]?
}

extension LocalMovieDataSourceImpl: LocalMovieDataSource {
    func getTrending() -> [MovieVM]? {
        movieList
    }

    func setTrending(movies: [MovieVM]) {
        movieList = movies
    }
}
