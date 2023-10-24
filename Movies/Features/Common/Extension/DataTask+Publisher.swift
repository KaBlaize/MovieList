//
//  DataTask+Publisher.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Combine
import Foundation

extension DataTask {
    static func asLoadedPublisher(data: T) -> AnyPublisher<DataTask<T, E>, Never> {
        Just(.loaded(data: data))
            .eraseToAnyPublisher()
    }
}
