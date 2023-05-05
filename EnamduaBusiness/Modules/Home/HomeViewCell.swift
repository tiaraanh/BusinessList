//
//  HomeViewCell.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import UIKit

class HomeViewCell: UITableViewCell {
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 10
        thumbImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(business: Business?) {
        guard let business = business else { return }
        nameLabel.text = business.name
        ratingLabel.text = "\(business.rating)🌟"
        reviewLabel.text = "Review: \(business.reviewCount)"
    }

}
