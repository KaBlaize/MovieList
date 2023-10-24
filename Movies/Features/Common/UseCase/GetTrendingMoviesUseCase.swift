//
//  GetTrendingMoviesUseCase.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine
import Foundation

protocol GetTrendingMoviesUseCase {
    func execute() -> AnyPublisher<DataTask<MovieListModel, ApiError>, Never>
}

final class GetTrendingMoviesUseCaseImpl {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }
}

extension GetTrendingMoviesUseCaseImpl: GetTrendingMoviesUseCase {
    func execute() -> AnyPublisher<DataTask<MovieListModel, ApiError>, Never> {
        repository
            .getTrending()
            .mapLoaded { movieList in
                .init(
                    movies: movieList,
                    maxPopularity: movieList
                        .map { $0.popularity }
                        .reduce(0, { $0 > $1 ? $0 : $1 })
                )
            }
    }
}
