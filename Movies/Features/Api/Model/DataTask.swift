//
//  DataTask.swift
//  Movies
//
//  Created by Balazs Kanyo on 22/10/2023.
//

import Foundation

enum DataTask<T: Codable, E: Error> {
    case loading
    case loaded(data: T)
    case failed(error: E)
}
