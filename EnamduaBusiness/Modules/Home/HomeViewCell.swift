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
    
    @IBOutlet var reviewCount: UILabel!
    @IBOutlet var rating: UILabel!
    
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

}
