//
//  Dependencies.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

// TODO: Due to time.. I'll make it just work.

protocol HasGetTrendingMoviesUseCase {
    func makeGetTrendingMoviesUseCase() -> GetTrendingMoviesUseCase
}

protocol MovieListDependencies: HasGetTrendingMoviesUseCase {

}

struct MovieListDependenciesImpl: MovieListDependencies {
    var localMovieDataSource = LocalMovieDataSourceImpl()

    func makeGetTrendingMoviesUseCase() -> GetTrendingMoviesUseCase {
        GetTrendingMoviesUseCaseImpl(repository: makeMovieRepository())
    }

    private func makeMovieRepository() -> MovieRepository {
        MovieRepositoryImpl(
            localDataSource: localMovieDataSource,
            remoteDataSource: RemoteMovieDataSourceImpl(api: TmdbApiImpl())
        )
    }
}
