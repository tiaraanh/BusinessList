//
//  CategoryDetailsViewCell.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 05/05/23.
//

import UIKit

class CategoryDetailsViewCell: UICollectionViewCell {
    @IBOutlet var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 10
        thumbImageView.layer.masksToBounds = true
    }
    
    var business: Business?
    
    func updateViews(business: Business) {
        thumbImageView.load(url: business.imageURL)
    }
    
}
