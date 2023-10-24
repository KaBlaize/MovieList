//
//  MovieVM+Extension.swift
//  Movies
//
//  Created by Balazs Kanyo on 23/10/2023.
//

import Foundation

extension MovieVM {
    func asToggled() -> MovieVM {
        var toggledMovie = self
        toggledMovie.isMarked.toggle()
        return toggledMovie
    }
}
