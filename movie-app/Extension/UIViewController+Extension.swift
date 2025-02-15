//
//  UIViewController+Extension.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation
import UIKit

extension UIViewController {
    func add(viewController: UIViewController, to view: UIView) {
        viewController.willMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        viewController.view.layoutIfNeeded()
    }
}
