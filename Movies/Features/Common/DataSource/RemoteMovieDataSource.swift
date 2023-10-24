//
//  RemoteMovieDataSource.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine
import Foundation

protocol RemoteMovieDataSource {
    func getTrending() -> AnyPublisher<MovieVMDataTask, Never>
}

final class RemoteMovieDataSourceImpl {
    private typealias Mapper = MovieVMMapper
    private let api: TmdbApi

    init(api: TmdbApi) {
        self.api = api
    }
}

extension RemoteMovieDataSourceImpl: RemoteMovieDataSource {
    func getTrending() -> AnyPublisher<MovieVMDataTask, Never> {
        api
            .getTrending()
            .mapLoaded { Mapper.map($0.results) }
    }
}
