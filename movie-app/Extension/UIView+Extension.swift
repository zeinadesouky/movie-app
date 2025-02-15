//
//  UIView+Extension.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation
import UIKit

private var loadingIndicatorTag = 999999

extension UIView {
    
    func showLoading() {
        if viewWithTag(loadingIndicatorTag) != nil { return }
        
        let loadingView = UIView(frame: bounds)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.4) // Semi-transparent background
        loadingView.tag = loadingIndicatorTag
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        addSubview(loadingView)
    }
    
    func hideLoading() {
        viewWithTag(loadingIndicatorTag)?.removeFromSuperview()
    }
}
