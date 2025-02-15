//
//  CastAndCrewVC.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import UIKit

protocol CastAndCrewView: AnyObject {
    func displayError(_ message: String)
    func reloadCollectionViews()
    func showContainerLoader()
    func hideContainerLoader()
}

class CastAndCrewVC: UIViewController, CastAndCrewView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var castCollectionView: UICollectionView!
    @IBOutlet private weak var crewCollectionView: UICollectionView!
    
    var presenter: CastAndCrewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadSimilarMovies()
        castCollectionView.register(UINib(nibName: "CastAndCrewCell", bundle: nil), forCellWithReuseIdentifier: "CastAndCrewCell")
        crewCollectionView.register(UINib(nibName: "CastAndCrewCell", bundle: nil), forCellWithReuseIdentifier: "CastAndCrewCell")
    }
    
    func displayError(_ message: String) {
        print("Error: \(message)")
    }
    
    func reloadCollectionViews() {
        castCollectionView.reloadData()
        crewCollectionView.reloadData()
    }
    
    func showContainerLoader() {
        containerView.showLoading()
    }
    
    func hideContainerLoader() {
        containerView.hideLoading()
    }

}

extension CastAndCrewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView{
            presenter.rowsInCastSection(section: section)
        } else { presenter.rowsInCrewSection(section: 1) }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastAndCrewCell", for: indexPath) as! CastAndCrewCell
        if collectionView == castCollectionView {
            presenter.configureCast(cell: cell, at: indexPath)
        } else { presenter.configureCrew(cell: cell, at: indexPath) }
        return cell
    }
    
}

extension CastAndCrewVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 107, height: 200)
    }
}
