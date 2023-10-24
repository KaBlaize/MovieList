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
    func getTrending() -> AnyPublisher<MovieVMDataTask, Never>
    func mark(movie: MovieVM) -> Bool
}

final class MovieRepositoryImpl {
    private let localDataSource: LocalMovieDataSource
    private let remoteDataSource: RemoteMovieDataSource

    private var bag = Set<AnyCancellable>()

    init(localDataSource: LocalMovieDataSource, remoteDataSource: RemoteMovieDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

extension MovieRepositoryImpl: MovieRepository {
    func getTrending() -> AnyPublisher<MovieVMDataTask, Never> {
        remoteDataSource
            .getTrending()
            .sink(receiveValue: { [weak self] dataTask in
                self?.localDataSource.setTrending(movies: dataTask)
            })
            .store(in: &bag)

        return localDataSource
            .getTrending()
    }

    func mark(movie: MovieVM) -> Bool {
        localDataSource.mark(movie: movie)
    }
}
