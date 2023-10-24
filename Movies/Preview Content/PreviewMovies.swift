//
//  PreviewMovies.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

let previewMovies: [MovieVM] = [
    .init(
        id: UUID().uuidString,
        title: "The Croods: A New Age",
        genres: "CARTOON, FAMILY",
        overView: "Searching for a safer habitat, the prehistoric Crood family discovers an idyllic, walled-in paradise that meets all of its needs.",
        image: .init(
            small: "https://image.tmdb.org/t/p/w185/tbVZ3Sq88dZaCANlUcewQuHQOaE.jpg",
            large: "https://image.tmdb.org/t/p/w500/tbVZ3Sq88dZaCANlUcewQuHQOaE.jpg"),
        popularity: 7.6,
        isMarked: false
    ),
    .init(
        id: UUID().uuidString,
        title: "Monster Hunter",
        genres: "ACTION, FANTASY, THRILLER",
        overView: "A portal transports Cpt. Artemis and an elite unit of soldiers to a strange world where powerful monsters rule with deadly ferocity. Faced with relentless danger, the team encounters a mysterious hunter who may be their only hope to find a way home.",
        image: .init(
            small: "https://image.tmdb.org/t/p/w185/1UCOF11QCw8kcqvce8LKOO6pimh.jpg",
            large: "https://image.tmdb.org/t/p/w500/1UCOF11QCw8kcqvce8LKOO6pimh.jpg"),
        popularity: 7.1,
        isMarked: true
    ),
    .init(
        id: UUID().uuidString,
        title: "Deathstroke: Knights & Dragons - The Movie",
        genres: "ACTION, FANTASY",
        overView: "The assassin Deathstroke tries to save his family from the wrath of H.I.V.E. and the murderous Jackal.",
        image: .init(
            small: "https://image.tmdb.org/t/p/w185/vFIHbiy55smzi50RmF8LQjmpGcx.jpg",
            large: "https://image.tmdb.org/t/p/w500/vFIHbiy55smzi50RmF8LQjmpGcx.jpg"),
        popularity: 6.9,
        isMarked: false
    )
]
