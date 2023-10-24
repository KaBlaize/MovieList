//
//  Dependencies.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

// TODO: Due to time.. I'll make it just work.

// MARK: - UseCases
protocol HasGetTrendingMoviesUseCase {
    func makeGetTrendingMoviesUseCase() -> GetTrendingMoviesUseCase
}

protocol HasMarkMovieUseCase {
    func makeMarkMovieUseCase() -> MarkMovieUseCase
}

// MARK: - Features / Scenes
protocol MovieDetailsDependencies: HasMarkMovieUseCase {}

protocol MovieListDependencies: HasGetTrendingMoviesUseCase, MovieDetailsDependencies {}

// MARK: - Implementation
struct MovieListDependenciesImpl: MovieListDependencies {
    var localMovieDataSource = LocalMovieDataSourceImpl()

    func makeGetTrendingMoviesUseCase() -> GetTrendingMoviesUseCase {
        GetTrendingMoviesUseCaseImpl(repository: makeMovieRepository())
    }

    func makeMarkMovieUseCase() -> MarkMovieUseCase {
        MarkMovieUseCaseImpl(repository: makeMovieRepository())
    }

    private func makeMovieRepository() -> MovieRepository {
        MovieRepositoryImpl(
            localDataSource: localMovieDataSource,
            remoteDataSource: RemoteMovieDataSourceImpl(api: TmdbApiImpl())
        )
    }
}
