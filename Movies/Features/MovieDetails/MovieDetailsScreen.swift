//
//  MovieDetailsScreen.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation
import SwiftUI

protocol MovieDetailsScreenViewModelProtocol: ObservableObject {
    var movie: MovieVM { get }

    func markMovie()
}

struct MovieDetailsScreen<ViewModel: MovieDetailsScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            Color.clear
                .aspectRatio(0.7, contentMode: .fill)
                .overlay(AsyncImage(url: viewModel.movie.image.large))
                .clipped()
                .overlay {
                    LinearGradient(
                        colors: [
                            Color(uiColor: .systemBackground).opacity(0.001),
                            Color(uiColor: .systemBackground)
                        ],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                }

            VStack(spacing: 16) {
                Button(action: { viewModel.markMovie() }) {
                        Image(systemName: viewModel.movie.isMarked ? "star.fill":  "plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(viewModel.movie.isMarked ? .yellow : .black)
                }
                .padding(8)
                .background(Material.regularMaterial)
                .cornerRadius(8)
                .shadow(radius: 24)

                Text("Overview")
                    .font(.title)
                    .fontWeight(.bold)
                Text(viewModel.movie.overView)
                    .font(.body)
            }
            .offset(y: -100)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.movie.title)
    }
}

struct MovieDetailsScreem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieDetailsScreen(viewModel: MockMovieDetailsViewModel())
                .preferredColorScheme(.light)
            MovieDetailsScreen(viewModel: MockMovieDetailsViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
