//
//  BeachCell.swift
//  HeyBeach
//

import UIKit

class BeachCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Methods
    func displayContent(_ beach: BeachGalleryModel.Beach) {
        imageView.image = beach.image
    }
}
