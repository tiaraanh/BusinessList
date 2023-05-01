//
//  HomeViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import UIKit
import Kingfisher

@available(iOS 13.0, *)
class HomeViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchTime: Timer?
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
    
    func searchBusiness(with term: String) {
        searchTime?.invalidate()
        searchTime = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (timer) in
            self?.viewModel.searchBusiness(with: term) { [weak self] (result) in
                self?.tableView.reloadData()
            }
        })
    }
}

// MARK: - UISearchBarDelegate
@available(iOS 13.0, *)
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count >= 3 {
            searchBusiness(with: text)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count >= 3 {
            searchBusiness(with: text)
        }
    }
}

// MARK: - UITableViewDataSource
@available(iOS 13.0, *)
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfBusiness
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCellId", for: indexPath) as! HomeViewCell
        
        let index = indexPath.row
        cell.nameLabel.text = viewModel.businessName(at: index)

        
        cell.thumbImageView.kf.setImage(with: URL(string: viewModel.businessImageUrl(at: index))) {
            (result) in
            switch result {
            case .success:
                cell.thumbImageView.contentMode = .scaleAspectFill
            case .failure:
                cell.thumbImageView.contentMode = .center
                cell.thumbImageView.image = UIImage(systemName: "photo")
            }
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate
@available(iOS 13.0, *)
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailsViewController()
    }
    
    
}
