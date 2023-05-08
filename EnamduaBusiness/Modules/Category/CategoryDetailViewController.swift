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
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var availableLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var userReviewLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mapView: MKMapView!
    
    var businessArray: [Business] = []
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        getLoadBusiness()
        updateViews()
        available()
        updateMaps()
        
        let reviewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userReview(tapGestureRecognizer:)))
            userReviewLabel.isUserInteractionEnabled = true
            userReviewLabel.addGestureRecognizer(reviewTapGestureRecognizer)
    }
    
// MARK: - Functions
    func setup() {
        mapView.layer.cornerRadius = 20
        mapView.layer.masksToBounds = true
        mapView.isScrollEnabled = false
        mapView.delegate = self
        
        collectionView.dataSource = self
    }
    
    func getLoadBusiness() {
        APIService.shared.loadBusiness(searchTerm: "restaurants") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self.businessArray = list
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("Error\(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateViews() {
        guard let business = business else { return }
        print("business contains value \(business)")
        nameLabel.text = business.name
        ratingLabel.text = "\(business.rating)🌟"
        priceLabel.text = business.price
        phoneLabel.text = business.displayPhone
        
        let displayAddress = business.location?.displayAddress
        let searchAddress = displayAddress?.joined()
        addressLabel.text = searchAddress
    }
    
    @objc func userReview(tapGestureRecognizer: UITapGestureRecognizer) {
        _ = tapGestureRecognizer.view as! UILabel
        guard let business = business,
              let url = URL(string: business.url)
        else { return }
        print(business.url)
        UIApplication.shared.open(url)
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

//MARK: - CollectionViewDataSource
@available(iOS 16.0, *)
extension CategoryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("business count: \(businessArray.count)")
        return businessArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryDetailsCellId", for: indexPath) as? CategoryDetailsViewCell
        else { return UICollectionViewCell() }
        
        let business = businessArray[indexPath.row]
        cell.thumbImageView.load(url: business.imageURL)
        
        return cell
    }
}
