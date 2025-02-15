//
//  SimilarMoviesVC.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import UIKit

protocol SimilarMoviesView: AnyObject {
    func displayError(_ message: String)
    func reloadCollectionView()
    func showContainerLoader()
    func hideContainerLoader()
    func removeSimilarMoviesContainer()
}

protocol SimilarMoviesDelegate: AnyObject {
    func shouldRemoveSimilarMoviesContainer()
}

class SimilarMoviesVC: UIViewController, SimilarMoviesView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var presenter: SimilarMoviesPresenter!
    weak var delegate: SimilarMoviesDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadSimilarMovies()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SImilarMovieCell", bundle: nil), forCellWithReuseIdentifier: "SImilarMovieCell")

    }
    
    func displayError(_ message: String) {
        print("Error: \(message)")
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func showContainerLoader() {
        containerView.showLoading()
    }
    
    func hideContainerLoader() {
        containerView.hideLoading()
    }
    
    func removeSimilarMoviesContainer() {
        delegate?.shouldRemoveSimilarMoviesContainer()
    }
}

extension SimilarMoviesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.rowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SImilarMovieCell", for: indexPath) as! SImilarMovieCell
        presenter.configure(cell: cell, at: indexPath)
        return cell
    }
    
}

extension SimilarMoviesVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 107, height: 200)
    }
}
