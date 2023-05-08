//
//  CategoryListViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 03/05/23.
//

import UIKit

@available(iOS 16.0, *)
class CategoryListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var categories: Category?
    var businessArray: [Business] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        getLoadCategories()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.rowHeight = 120
    }
    
    func getLoadCategories() {
        guard let category = categories else { return }
        APIService.shared.loadBusiness(searchTerm: category.title) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let business):
                    self.businessArray = business
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
}

// MARK: - TableViewDataSource
@available(iOS 16.0, *)
extension CategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("business count: \(businessArray.count)")
        return businessArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryListCellId", for: indexPath) as? CategoryListViewCell,
              let category = categories
        else { return UITableViewCell() }
        
        let business = businessArray[indexPath.row]
        
        cell.titleLabel.text = business.name
        cell.ratingLabel.text = "\(business.rating)🌟"
        cell.reviewLabel.text = "Review: \(business.reviewCount)"
        cell.thumbImageView.image = UIImage(named: category.imageName)
        print(category.title)
        
        return cell
    }
    
}

//MARK: - Navigation
@available(iOS 16.0, *)
extension CategoryListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCategoryListDestination" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? CategoryDetailViewController
            else { return }

            let selectedBusiness = businessArray[indexPath.row]
            destination.business = selectedBusiness
        }
    }
}

