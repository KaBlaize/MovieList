//
//  ContentView.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI

protocol MovieListScreenViewModelProtocol: ObservableObject {
    associatedtype DetailsViewModel: MovieDetailsScreenViewModelProtocol
    
    var movies: [MovieVM] { get }
    var maxPopularity: Float { get }

    func load()
    func getMovieDetailsScreenViewModel(for movie: MovieVM) -> DetailsViewModel
}

struct MovieListScreen<ViewModel: MovieListScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: destinationView(using: movie)) {
                    MovieListItemView(movie: movie, maxPopularity: viewModel.maxPopularity)
                        .padding(.trailing, 8)
                }
                .padding(.trailing, 16)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Movies")
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: {
            viewModel.load()
        })
    }

    func destinationView(using movie: MovieVM) -> some View {
        MovieDetailsScreen(viewModel: viewModel.getMovieDetailsScreenViewModel(for: movie))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieListScreen(viewModel: MockViewModel())
                .preferredColorScheme(.light)
            MovieListScreen(viewModel: MockViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
