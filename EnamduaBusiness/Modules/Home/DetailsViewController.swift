//
//  DetailsViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 30/04/23.
//

import UIKit
import MapKit

@available(iOS 16.0, *)
class DetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    
    var businessArray: [Business] = []
    var business: Business?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        setup()
        available()
        updateMaps()
    }
    
    func setup() {
        thumbImageView.layer.cornerRadius = 10
        thumbImageView.layer.masksToBounds = true
        
        mapView.layer.cornerRadius = 20
        mapView.layer.masksToBounds = true
        mapView.isScrollEnabled = false
        mapView.delegate = self
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
    
    func updateViews() {
        guard let business = business else { return }
        print("business contains value \(business)")
        nameLabel.text = business.name
        ratingLabel.text = "\(business.rating)🌟"
        reviewLabel.text = "Review: \(business.reviewCount)"
        thumbImageView.load(url: business.imageURL)
        priceLabel.text = business.price
        
        let displayAddress = business.location?.displayAddress
        let searchAddress = displayAddress?.joined()
        addressLabel.text = searchAddress
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
    
}

// MARK: - MKMapViewDelegate
@available(iOS 16.0, *)
extension DetailsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
        routeToPlace()
    }

    func routeToPlace() {
        let actionSheet = UIAlertController(title: "Directions using", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Maps", style: .default, handler: { (_) in
            self.openMaps()
        }))
        
        if canOpen(urlScheme: "comgooglemaps") {
            actionSheet.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { (_) in
                self.openGoogleMaps()
            }))
        }

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
    
    func canOpen(urlScheme: String) -> Bool {
        var components = URLComponents()
        components.scheme = urlScheme
        if let url = components.url {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func openGoogleMaps() {
        guard let business = business else { return }
        let latitude = business.coordinates?.latitude
        let longitude = business.coordinates?.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude ?? 0, longitude ?? 0)
        let latString = String(format: "%.6f", coordinate.latitude)
        let lngString = String(format: "%.6f", coordinate.longitude)
        let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latString),\(lngString)&directionsmode=driving")!
        let application = UIApplication.shared
        if application.canOpenURL(url) {
            application.open(url)
        }
    }
}
