//
//  TmdbApiError.swift
//  Movies
//
//  Created by Balazs Kanyo on 22/10/2023.
//

import Foundation

enum ApiError: Error {
    case network, api, serialization, weakSelfIsNil
}
