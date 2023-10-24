//
//  Publisher+DataTask.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine

extension Publisher where Failure == Never {
    func mapLoaded<T, E: Error, R>(_ mappingFunction: @escaping (T) -> R) -> AnyPublisher<DataTask<R, E>, Never> where Output == DataTask<T, E> {
        map { dataTask -> DataTask<R, E> in
            switch dataTask {
            case .loading:
                return .loading
            case .loaded(let data):
                return .loaded(data: mappingFunction(data))
            case .failed(let error):
                return .failed(error: error)
            }
        }
        .eraseToAnyPublisher()
    }

    func handleLoaded<T, E: Error>(_ callback: @escaping (T) -> Void) -> AnyPublisher<DataTask<T, E>, Never> where Output == DataTask<T, E> {
        handleEvents(receiveOutput: { dataTask in
            switch dataTask {
            case .loaded(let movieList):
                callback(movieList)
            default: break
            }
        })
        .eraseToAnyPublisher()
    }
}
