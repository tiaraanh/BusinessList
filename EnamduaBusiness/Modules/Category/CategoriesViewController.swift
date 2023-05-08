//
//  CategoriesViewController.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import UIKit

@available(iOS 16.0, *)
class CategoriesViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    private let inset: CGFloat = 20
    private let spacing: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        collectionViewLayout.minimumLineSpacing = spacing
        collectionViewLayout.minimumInteritemSpacing = spacing
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = collectionViewLayout
    }

}
//MARK: - CollectionViewDataSource
@available(iOS 16.0, *)
extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoriesList.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCellId", for: indexPath) as? CategoriesViewCell
        else { return UICollectionViewCell() }
        
        let category = CategoriesList.categories[indexPath.row]
        cell.updateViews(category: category)
        
        let width = floor((UIScreen.main.bounds.width - (inset * 2) - spacing) / 2)
        cell.widthConstraint.constant = width
        cell.setNeedsLayout()
        
        return cell
    }

}
//MARK: - CollectionViewDelegate
@available(iOS 16.0, *)
extension CategoriesViewController: UICollectionViewDelegate {
    

}

//MARK: - Navigation
@available(iOS 16.0, *)
extension CategoriesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryListDestination" {
            guard let destination = segue.destination as? CategoryListViewController,
                       let cell = sender as? CategoriesViewCell,
                       let indexPath = self.collectionView.indexPath(for: cell)
                 else { return }
                         
                 let selectedCategory = CategoriesList.categories[indexPath.row]
                 destination.categories = selectedCategory
        }
    }
    
}


