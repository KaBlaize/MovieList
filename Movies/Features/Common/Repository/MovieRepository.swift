//
//  MovieRepository.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation
import Combine

protocol MovieRepository {
    /// Get trending movies from local datasource if possible. Otherwise fetch from remote and cache before return the list.
    func getTrending() -> AnyPublisher<DataTask<[MovieVM], ApiError>, Never>
    func mark(movie: MovieVM) -> Bool
}

final class MovieRepositoryImpl {
    private let localDataSource: LocalMovieDataSource
    private let remoteDataSource: RemoteMovieDataSource

    init(localDataSource: LocalMovieDataSource, remoteDataSource: RemoteMovieDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

extension MovieRepositoryImpl: MovieRepository {
    func getTrending() -> AnyPublisher<DataTask<[MovieVM], ApiError>, Never> {
        if let movieList = localDataSource.getTrending() {
            return DataTask
                .asLoadedPublisher(data: movieList)
        }
        
        return remoteDataSource
            .getTrending()
            .handleLoaded { [weak self] movieList in
                self?.localDataSource.setTrending(movies: movieList)
            }
    }

    func mark(movie: MovieVM) -> Bool {
        guard let cachedList = localDataSource.getTrending() else {
            localDataSource.setTrending(movies: [movie.asToggled()])
            return !movie.isMarked
        }

        localDataSource
            .setTrending(
                movies: cachedList
                    .map {
                        movie.id == $0.id ? $0.asToggled() : $0
                    }
            )

        return !movie.isMarked
    }
}
