//
//  CastAndCrewModuleBuilder.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation
import UIKit

class CastAndCrewModuleBuilder {
    static func build(with movieId: Int) -> CastAndCrewVC {
        let similarMoviesService = FetchSimilarMoviesService()
        let similarMoviesUseCase = FetchSimilarMoviesUseCaseImp(service: similarMoviesService)
        let creditsService = FetchCreditsService()
        let creditsUseCase = FetchCreditsUseCaseImp(service: creditsService)
        let viewController = CastAndCrewVC()
        let presenter = CastAndCrewPresenter(view: viewController,
                                             fetchSimilarMoviesUseCase: similarMoviesUseCase,
                                             fetchCastAndCrewUseCase: creditsUseCase,
                                             movieId: movieId)
        viewController.presenter = presenter
        return viewController
    }
}
