//
//  SimilarMoviesModuleBuilder.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation
import UIKit

class SimilarMoviesModuleBuilder {
    static func build(with movieId: Int) -> SimilarMoviesVC {
        let service = FetchSimilarMoviesService()
        let useCase = FetchSimilarMoviesUseCaseImp(service: service)
        let viewController = SimilarMoviesVC()
        let presenter = SimilarMoviesPresenter(view: viewController,
                                               fetchSimilarMoviesUseCase: useCase,
                                               movieId: movieId)
        viewController.presenter = presenter
        return viewController
    }
}
