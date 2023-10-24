//
//  Publishers+DataTask.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine

extension Publishers.CombineLatest {
    func mapLoaded<AOutput, BOutput, C>(_ mapperFunction: @escaping (AOutput, BOutput) -> C) -> AnyPublisher<DataTask<C, ApiError>, Never>
    where A.Output == DataTask<AOutput, ApiError>, B.Output == DataTask<BOutput, ApiError>, A.Failure == Never, B.Failure == Never
    {
        map { dataTask1, dataTask2 -> DataTask<C, ApiError> in
            if case let .loaded(data1) = dataTask1, case let .loaded(data2) = dataTask2  {
                return .loaded(data: mapperFunction(data1, data2))
            } else if case let .failed(error) = dataTask1 {
                return .failed(error: error)
            } else if case let .failed(error) = dataTask2 {
                return .failed(error: error)
            } else {
                return .loading
            }
        }
        .eraseToAnyPublisher()
    }
}
