//
//  MoviesApp.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI

@main
struct MoviesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let movieListDependencies = MovieListDependenciesImpl()

    var body: some Scene {
        WindowGroup {
            MovieListScreen(viewModel: MovieListScreenViewModel(dependencies: movieListDependencies))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // TODO: Put your "appdelegate" code here
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("Appdelegate -> open \(url)")
        return false
    }
}
