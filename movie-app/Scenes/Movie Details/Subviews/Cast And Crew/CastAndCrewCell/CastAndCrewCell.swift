//
//  CastAndCrewCell.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import UIKit

class CastAndCrewCell: UICollectionViewCell {
    
    @IBOutlet private weak var personalPhoto: UIImageView!
    @IBOutlet private weak var originalName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        personalPhoto.layer.cornerRadius = 40
    }

    func configure(with personnelInfo: PersonnelInfo) {
        personalPhoto.setImage(personnelInfo.profilePath ?? "")
        originalName.text = personnelInfo.originalName ?? ""
    }
}
