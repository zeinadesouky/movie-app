//
//  MovieListBuilder.swift
//  movie-app
//
//  Created by Robusta on 13/02/2025.
//

import Foundation
import UIKit

class MovieListModuleBuilder {
    static func build() -> MovieListVC {
        let service = FetchMoviesService()
        let useCase = FetchMoviesUseCaseImp(movieService: service)
        let viewController = MovieListVC()
        let presenter = MovieListPresenter(view: viewController, fetchMoviesUseCase: useCase)
        viewController.presenter = presenter
        return viewController
    }
}
