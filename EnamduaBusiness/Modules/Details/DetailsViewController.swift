//
//  DetailsViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 30/04/23.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var business: Business?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        guard let business = business else { return }
        print("business contains value \(business)")
        nameLabel.text = business.name
        ratingLabel.text = "Rating: \(business.rating))"
        reviewLabel.text = "Review: \(business.reviewCount))"
        thumbImageView.load(url: business.imageURL)
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}

