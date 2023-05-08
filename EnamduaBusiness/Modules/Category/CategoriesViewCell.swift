//
//  CategoriesViewCell.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 03/05/23.
//

import UIKit

class CategoriesViewCell: UICollectionViewCell {
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 20
        thumbImageView.layer.masksToBounds = true
    }
    
    var category: Category?
    
    func updateViews(category: Category) {
        thumbImageView.image = UIImage(named: category.imageName)
        nameLabel.text = category.title
    }
}
