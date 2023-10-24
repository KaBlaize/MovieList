//
//  LocalMovieDataSource.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine
import Foundation

protocol LocalMovieDataSource {
    func getTrending() -> AnyPublisher<MovieVMDataTask, Never>
    func setTrending(movies: MovieVMDataTask)
    func mark(movie: MovieVM) -> Bool
}

final class LocalMovieDataSourceImpl {
    private let movieListSubject = CurrentValueSubject<MovieVMDataTask, Never>(.loading)
}

extension LocalMovieDataSourceImpl: LocalMovieDataSource {
    func getTrending() -> AnyPublisher<MovieVMDataTask, Never> {
        movieListSubject
            .eraseToAnyPublisher()
    }

    func setTrending(movies: MovieVMDataTask) {
        movieListSubject
            .send(movies)
    }

    func mark(movie: MovieVM) -> Bool {
        guard case let .loaded(movies) = movieListSubject.value else { return false }

        movieListSubject
            .send(.loaded(data: movies.map {
                $0.id == movie.id ? $0.asToggled() : $0
            }))

        return !movie.isMarked
    }
}
