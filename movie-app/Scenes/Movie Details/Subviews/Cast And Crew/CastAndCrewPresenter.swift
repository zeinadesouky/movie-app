//
//  CastAndCrewPresenter.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

class CastAndCrewPresenter {
    weak var view: CastAndCrewView?
    private let fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase
    private let fetchCastAndCrewUseCase: FetchCreditsUseCase
    private let movieId: Int?
    private var cast: [PersonnelInfo] = []
    private var crew: [PersonnelInfo] = []
    
    init(view: CastAndCrewView, fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase, fetchCastAndCrewUseCase: FetchCreditsUseCase, movieId: Int) {
        self.view = view
        self.fetchSimilarMoviesUseCase = fetchSimilarMoviesUseCase
        self.fetchCastAndCrewUseCase = fetchCastAndCrewUseCase
        self.movieId = movieId
    }
    
    func rowsInCastSection(section: Int) -> Int {
         min(cast.count, 5)
    }
    
    func rowsInCrewSection(section: Int) -> Int {
         min(crew.count, 5)
    }
    
    func configureCast(cell: CastAndCrewCell, at indexPath: IndexPath) {
        let cast = cast[indexPath.row]
        cell.configure(with: cast)
    }
    
    func configureCrew(cell: CastAndCrewCell, at indexPath: IndexPath) {
        let crew = crew[indexPath.row]
        cell.configure(with: crew)
    }
    
    func loadSimilarMovies() {
        guard let movieId else { return }
        self.view?.showContainerLoader()
        fetchSimilarMoviesUseCase.execute(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.loadSimilarMoviesCredits(movieIds: movies.results?.compactMap({$0.id}) ?? [])
                case .failure(let error):
                    self?.view?.displayError(error.localizedDescription)
                    self?.view?.hideContainerLoader()
                }
            }
        }
    }
    
    func loadSimilarMoviesCredits(movieIds: [Int]) {
        fetchCastAndCrewUseCase.executeMultiple(movieIds: movieIds) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let credits):
                    let credits = credits.values
                    self?.filterCreditsInfo(credits: Array(credits))
                    self?.view?.hideContainerLoader()
                case .failure(let error):
                    self?.view?.displayError(error.localizedDescription)
                    self?.view?.hideContainerLoader()
                }
            }
        }
    }
    
    func filterCreditsInfo(credits: [CreditsResponse]) {
        let allCast = credits.flatMap {($0.cast ?? [])}
            .filter {($0.knownForDepartment == "Acting")}
        
        let allCrew = credits.flatMap {($0.crew ?? [])}
            .filter {($0.knownForDepartment == "Directing")}

        self.cast = getUniquePersonnel(from: allCast)
        self.crew = getUniquePersonnel(from: allCrew)

        self.view?.reloadCollectionViews()
    }

    private func getUniquePersonnel(from personnel: [PersonnelInfo]) -> [PersonnelInfo] {
        let groupedByName = Dictionary(grouping: personnel) {($0.originalName ?? "" )}
        
        let uniquePersonnel = groupedByName.compactMapValues { entries in
            entries.max(by: { ($0.popularity ?? 0) < ($1.popularity ?? 0) })
        }
        
        return uniquePersonnel.values.sorted { ($0.popularity ?? 0) > ($1.popularity ?? 0) }
    }


}
