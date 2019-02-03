//
//  BeachCell.swift
//  HeyBeach
//

import UIKit

class BeachCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label_title: UILabel!
    
    // MARK: - Methods
    func displayContent(_ beach: BeachGalleryModel.Beach) {
        imageView.image = beach.image
        label_title.text = beach.title
    }
}
