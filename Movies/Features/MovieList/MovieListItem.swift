//
//  MovieListItem.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI

struct MovieListItem: View {

    let movie: MovieVM

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                AsyncImage(url: movie.image.small)
                    .frame(width: 80, height: 80 * 1.7778)
                    .clipped()
            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if movie.isMarked {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.yellow)
                            .shadow(color: .yellow, radius: 4)
                    }
                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(2)
                }
                Text(movie.genres)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                HStack {
                    ProgressView(value: movie.popularity / 10)
                    Text(String(format: "%.1f", movie.popularity))
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .layoutPriority(1)
            }
        }
    }
}


struct MovieListItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItem(movie: previewMovies[1])
    }
}

