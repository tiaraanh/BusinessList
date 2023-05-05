//
//  CategoryDetailViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 03/05/23.
//

import UIKit
import MapKit

@available(iOS 16.0, *)
class CategoryDetailViewController: UIViewController {
    
// MARK: - Properties
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var availableLabel: UILabel!
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userReviewLabel: UILabel!
    @IBOutlet var userRatingLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    var business: Business?
    var reviews: ReviewList?
    var review: [ReviewList] = [ReviewList]()
    public var businessId: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        getLoadReviews()
        renderViews()
        updateReviews()
        available()
        updateMaps()
    }
    
// MARK: - Functions
    func setup() {
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.layer.cornerRadius = 20
        thumbImageView.layer.masksToBounds = true
        
        mapView.layer.cornerRadius = 20
        mapView.layer.masksToBounds = true
        mapView.isScrollEnabled = false
        mapView.delegate = self
    }
    
    func renderViews() {
        guard let business = business else { return }
        print("business contains value \(business)")
        thumbImageView.load(url: business.imageURL)
        nameLabel.text = business.name
        ratingLabel.text = "\(business.rating)🌟"
        priceLabel.text = business.price
        
        let displayAddress = business.location?.displayAddress
        let searchAddress = displayAddress?.joined()
        addressLabel.text = searchAddress
    }
    
    func updateReviews() {
        guard let reviews = reviews else { return }
        print("review contains value \(reviews)")
        userNameLabel.text = reviews.user?.name
        userRatingLabel.text = "\(reviews.rating)🌟"
        userReviewLabel.text = reviews.text
    }
    
    func available() {
        if business?.isClosed == true {
            availableLabel.text = "ClOSED 🚫"
            availableLabel.font = .systemFont(ofSize: 15, weight: .bold)
            availableLabel.textColor = .systemRed
        } else {
            availableLabel.text = "OPEN ✅"
            availableLabel.font = .systemFont(ofSize: 15, weight: .bold)
            availableLabel.textColor = .systemGreen
        }
    }
    
    func updateMaps() {
        guard let business = business else { return }
        let latitude = business.coordinates?.latitude
        let longitude = business.coordinates?.longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
        let annoation = MKPointAnnotation()
        annoation.coordinate = coordinate
        mapView.addAnnotation(annoation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        mapView.setRegion(region, animated: true)
    }
    
    func getLoadReviews() {
        APIService.shared.loadBusinessReviews(with: businessId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self.review = list
                case .failure(let error):
                    print("Error\(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - MKMapViewDelegate
@available(iOS 16.0, *)
extension CategoryDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
        routeToPlace()
    }

    func routeToPlace() {
        let actionSheet = UIAlertController(title: "Directions using", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Maps", style: .default, handler: { (_) in
            self.openMaps()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }

    func openMaps() {
        guard let business = business else { return }
        let latitude = business.coordinates?.latitude
        let longitude = business.coordinates?.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude ?? 0, longitude ?? 0)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
