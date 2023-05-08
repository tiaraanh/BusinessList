//
//  HomeViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import UIKit

@available(iOS 16.0, *)
class HomeViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var business: [Business?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        getLoadBusiness()
    }
    
    func setup() {
        tableView.dataSource = self
        
        tableView.rowHeight = 120
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    func getLoadBusiness() {
        APIService.shared.loadBusiness(searchTerm: "restaurants") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self.business = list
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error\(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate
@available(iOS 16.0, *)
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count >= 3 {
            getLoadBusiness()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count >= 3 {
            getLoadBusiness()
        }
    }
}

// MARK: - UITableViewDataSource
@available(iOS 16.0, *)
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return business.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellId", for: indexPath) as? HomeViewCell,
              let business = business[indexPath.row]
        else { return UITableViewCell() }
        
        cell.updateViews(business: business)
        cell.thumbImageView.load(url: business.imageURL)
        
        return cell
    }
    
}

//MARK: - Navigation
@available(iOS 16.0, *)
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailHomeDestination" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? DetailsViewController
                    else { return }

            let selectedBusiness = business[indexPath.row]
            destination.business = selectedBusiness
        }
    }
    
}


